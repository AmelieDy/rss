class CreateContentsJob < ApplicationJob
  require 'rss'
  require "open-uri"
  queue_as :contents

  def perform(feed)
    url = feed.url
    ::OpenURI.open_uri(url) do |rss|
      result = RSS::Parser.parse(rss,validate: false)
      # puts "Title: #{result.channel.title}"
      result.items.each do |item|
        Content.create!(title: item.title,
                        description: item.description,
                        feed_id: feed.id,
                        url: item.link,
                        pub_date: item.pubDate,
                        readed: false)
      end
    end
  end
end
