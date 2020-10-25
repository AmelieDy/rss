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
  validate :is_rss


  # verify if url exist with net/http request
  def is_valid_url
    begin
      require "net/http"
      encoded_url = Addressable::URI.encode(self.url)
      uri = Addressable::URI.parse(encoded_url)
      http = Net::HTTP.new(uri.host, uri.port)
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

  # validate atom or rss from w3c validator
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

  # check if format is xml
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

  # check if format is xml, rss or atom
  def is_rss
    begin
      xml = Faraday.get(self.url).body
      parsed_feed = Feedjira.parse xml
    rescue => e
      errors.add(:url, "format attendu : rss")
      p e
    end
  end
end
