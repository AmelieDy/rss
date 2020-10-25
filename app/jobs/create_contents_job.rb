class CreateContentsJob < ApplicationJob
  # require 'rss'
  # require "open-uri"
  # require 'httparty'

  queue_as :contents

  def perform(feed)
    xml = Faraday.get(feed.url).body
    parsed_feed = Feedjira.parse xml
    parsed_feed.entries.each do |entry|
      p entry.entry_id
      Content.create!(title: entry.title,
                      description: entry.summary,
                      feed_id: feed.id,
                      document_feed_id: entry.entry_id,
                      url: entry.url,
                      pub_date: entry.published,
                      readed: false)
    end
  end
end
