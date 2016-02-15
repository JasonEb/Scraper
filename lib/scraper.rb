require_relative "websitemodel"
require 'nokogiri'
require 'open-uri'
require 'csv'

class AlexaScraper
  attr_reader :websites, :pages
  def initialize(url)
    @base_url = url
    @site_html = Nokogiri::HTML(open(url))
    @websites = []
    @page_urls = []
  end

  def scrape_pages(total, suffix)
    query_string = suffix.split("0")

    total.times do |x|
      url = @base_url + query_string[0] + x.to_s + query_string[1]
      @site_html = Nokogiri::HTML(open(url))
      scrape_page_listings
    end
  end

  def extract_websites_from(listings)
    listings.map do |listing|
      url = listing.css(".desc-paragraph a").inner_html
      name = url.gsub(/.(net|com|io|org)/, "")
      rank = listing.css(".count").inner_html
      Website.new(name, url, rank)
    end
  end

  def scrape_page_listings
    listings = @site_html.css('.site-listing')
    @websites += extract_websites_from(listings)
  end


end
