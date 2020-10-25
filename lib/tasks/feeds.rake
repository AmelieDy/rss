namespace :feeds do
  desc "TODO"
  task create_new_feed_items: :environment do
    @feeds = Feed.all
    @feeds.each do |feed|
      last_content = Time.parse(feed.contents.order('pub_date DESC').first.pub_date.strftime("%FT%T"))
      xml = Faraday.get(feed.url).body
      parsed_feed = Feedjira.parse xml
      parsed_feed.entries.each do |entry|
        date = Time.parse(entry.published.strftime("%FT%T"))
        if date > last_content
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
  end

end
