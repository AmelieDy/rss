namespace :feeds do
  desc "TODO"
  task create_new_feed_items: :environment do
    # this task is scheduled in config/schedule.rb
    @feeds = Feed.all
    @feeds.each do |feed|
      # parse publication the most recent publication date of feed contents
      last_content = Time.parse(feed.contents.order('pub_date DESC').first.pub_date.strftime("%FT%T"))
      # parse feed with Feedjira
      xml = Faraday.get(feed.url).body
      parsed_feed = Feedjira.parse xml
      # foreach entries, compare dates with last_content date
      # if date of entry is greater than the last_content date, create it
      parsed_feed.entries.each do |entry|
        date = Time.parse(entry.published.strftime("%FT%T"))
        if date > last_content
          p date
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
