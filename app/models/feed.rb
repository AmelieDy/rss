class Feed < ApplicationRecord
  include ActiveModel::Validations
  require 'nokogiri'
  require 'feed_validator'
  require "addressable/uri"

  has_many :contents
  validates_presence_of :title, :url
  validates_uniqueness_of :title, :url, case_sensitive: true
  validate :is_valid_url
  validate :w3c_validate
  validate :is_xml

  # verify if url exist with net/http request
  def is_valid_url
    begin
      require "net/http"
      encoded_url = Addressable::URI.encode(self.url)
      uri = Addressable::URI.parse(encoded_url)
      http = Net::HTTP.new(uri.host, uri.port)
      # http.use_ssl = true
      # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(req)
      puts res.code
    rescue => e
      # error occured, return false
      false
      errors.add(:url, "n'est pas une adresse existante")
      puts "Exceptions : #{e}"
    end
  end

  def w3c_validate
    begin
      v = W3C::FeedValidator.new()
      v.validate_url(self.url)
      puts v.to_s unless v.valid?
    rescue => e
      # error occured, return false
      false
      errors.add(:url, "n'est pas un flux rss valide")
      puts "w3c validation errors : #{e}"
    end
  end

  def is_xml
    begin
      xml = Nokogiri::XML(open(self.url).read) do |config|
        config.strict.noblanks
      end
    rescue => e
      errors.add(:url, "n'est pas au format xml")
      p e
    end
  end

  #
  # def open_url
  #   rss_results = []
  #   url = self.url
  #   begin
  #     v = W3C::FeedValidator.new
  #     if v.validate_url(url) && v.valid?
  #       puts 'yey'
  #     else
  #       errors.add(:url, 'nop')
  #       puts errors
  #     end
  #   rescue
  #     puts 'oww'
  #   end
  # end

    # begin
    #   bad_doc = Nokogiri::XML(url) { |config| config.strict }
    # rescue Nokogiri::XML::SyntaxError => e
    #   puts "caught exception: #{e}"
    # end

  #   open(url) do |rss|
  #     result =  RSS::Parser.parse(rss)
  #     result.items.each do |item|
  #       result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
  #       rss_results.push(result)
  #     end
  #   end
  #   return rss_results
  #   if rss_results.empty?
  #     errors.add(:url, "no rss type")
  #   end
  # end
end
# url = self.url
# begin
#   Nokogiri::XML(url) { |config| config.strict }
# rescue Nokogiri::XML::SyntaxError => e
#   puts "caught exception: #{e}"
# end
# open(url) do |rss|
#   result = RSS::Parser.parse(rss)
#
#   result.items.each do |item|
#     Content.create!(title:        item.title,
#                     description:  item.description,
#                     feed_id:      feed.id,
#                     author:       item.author,
#                     category:     item.category,
#                     url:          item.link,
#                     pub_date:     item.pubDate,
#                     status:       0)
