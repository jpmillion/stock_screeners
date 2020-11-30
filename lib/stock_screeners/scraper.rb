require 'open-uri'
require 'nokogiri'
require 'pry'

class StockScreeners::Scraper
  
  def self.scrape_screeners_page(screeners_url)
    doc = Nokogiri::HTML(open(screeners_url))
    hashes = doc.css("#predefined-screeners a[href]").map {|e| {name: e.text, link: e['href']}}
    hashes.slice(1, 9)
  end
  
  def self.scrape_selected_screen_page(screen_url)
    doc = Nokogiri::HTML(open(screen_url))
    names = doc.css("#fin-scr-res-table tbody tr").map {|r| r.css("td").map {|d| d.text}}.map {|row| row[1]}.map {|name| {name: name}}
    links = doc.css("#fin-scr-res-table tbody tr").css("a[href]").map {|e| e['href']}.map {|quote| {link: quote}}
    #names = name.map {|name| {name: name}}
    #links = quotes_array.map {|quote| {link: quote}}
    stock_hashes = []
    i = 1 
    while i < 10 do
      stock_hashes << names[i].merge(links[i])
      i += 1
    end
    stock_hashes
  end
  
  def self.scrape_selected_stock_summary(summary_url)
    doc = Nokogiri::HTML(open(summary_url))
    table = doc.css("#quote-summary table")
    table.css("tr").map {|e| e.css("td").map {|e| e.text}}
  end
end