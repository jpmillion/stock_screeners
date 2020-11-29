require 'open-uri'
require 'nokogiri'
#require 'pry'

class StockScreeners::Scraper
  
  def self.scrape_screeners_page(screeners_url)
    doc = Nokogiri::HTML(open(screeners_url))
    table = doc.css("#predefined-screeners")
    screen_names = table.css("a[href]").map {|e| e.text}
    screen_names.slice(1, 9)
    #screen_links = doc.css("#predefined-screeners a[href]").map {|e| e['href']}
  end
  
  def self.scrape_screen_page(screen_url)
    doc = Nokogiri::HTML(open(screen_url))
    
  end
end