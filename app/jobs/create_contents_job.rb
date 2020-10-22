class CreateContentsJob < ApplicationJob
  queue_as :contents

  def perform(feed)
    require 'rss'
    require 'open-uri'

    url = feed.url
    open(url) do |rss|
      result = RSS::Parser.parse(rss)
      # puts "Title: #{result.channel.title}"
      result.items.each do |item|
        Content.create!(title: item.title,
                        description: item.description,
                        feed_id: feed.id,
                        author: item.author,
                        category: item.category,
                        url: item.link,
                        pub_date: item.pubDate,
                        status: 0)
      end
    end
  end
end
