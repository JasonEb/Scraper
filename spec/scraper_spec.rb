require "scraper"
require "byebug"

describe "Scraper" do
  let(:base_url) {"http://www.alexa.com/topsites/"}
  subject(:scraper) { AlexaScraper.new(base_url)}
  let(:results) { scraper.websites }

  it "scrapes base page for 25 websites" do
    scraper.scrape_page_listings
    expect(results.count).to be(25)
  end

  it "scrapes websites correctly" do
    website = Website.new("Google", "Google.com", "1")
    scraper.scrape_page_listings
    first_listing = results.first

    expect(first_listing.name).to eq(website.name)
    expect(first_listing.url).to eq(website.url)
    expect(first_listing.rank).to eq(website.rank)
  end

  it "scrapes_pages(4) returns 100 websites" do
    scraper.scrape_pages(4, "countries;0/US")

    results = scraper.websites
    expect(results.count).to be(100)
  end
end
