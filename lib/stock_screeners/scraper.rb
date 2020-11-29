require 'open-uri'
require 'nokogiri'
#require 'pry'

class StockScreeners::Scraper
  
  def self.scrape_screeners_page(screeners_url)
    doc = Nokogiri::HTML(open(screeners_url))
    screen_names = doc.css("#predefined-screeners a[href]").map {|e| e.text}
    screen_names.slice(1, 9)
  end
  
  def self.scrape_selected_screen_page(screen_url)
    doc = Nokogiri::HTML(open(screen_url))
    screen_links = doc.css("#predefined-screeners a[href]").map {|e| e['href']}
  end
end