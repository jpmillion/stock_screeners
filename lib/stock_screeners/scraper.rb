require 'open-uri'
require 'nokogiri'
require 'pry'

class StockScreeners::Scraper
  
  def self.scrape_screeners_page(screeners_url)
    doc = Nokogiri::HTML(open(screeners_url))
    hashes = doc.css("#predefined-screeners a[href]").map {|e| {name: e.text, link: e['href']}}
    #screens = 
    hashes.slice(1, 9)
    #screens.each {|screen| StockScreeners::Screen.new(screen)}
  end
  
  def self.scrape_selected_screen_page(screen_url)
    doc = Nokogiri::HTML(open(screen_url))
    # xx table_head_data_array = doc.css("#fin-scr-res-table thead th").map {|e| e.text}
    #table_row_data_array = doc.css("#fin-scr-res-table tbody tr").map {|r| r.css("td").map {|d| d.text}}.map {|row| row[1]}
    name = doc.css("#fin-scr-res-table tbody tr").map {|r| r.css("td").map {|d| d.text}}.map {|row| row[1]}
    quotes_array = doc.css("#fin-scr-res-table tbody tr").css("a[href]").map {|e| e['href']}
    #{rows: table_row_data_array, quotes: quotes_array} # xx headers: table_head_data_array,
    
  end
  
  def self.scrape_selected_stock_summary(summary_url)
    doc = Nokogiri::HTML(open(summary_url))
    table = doc.css("#quote-summary table")
    table.css("tr").map {|e| e.css("td").map {|e| e.text}}
  end
end