require 'open-uri'
require 'nokogiri'
#require 'pry'

class StockScreeners::Scraper
  
  def self.scrape_screeners_page(screeners_url)
    doc = Nokogiri::HTML(open(screeners_url))
    screen_links = doc.css("#predefined-screeners a[href]").map {|e| e['href']}
    screen_names = doc.css("#predefined-screeners a[href]").map {|e| e.text}
    links = screen_links.slice(1, 9)
    names = screen_names.slice(1, 9)
    hash = {screen_link: links, screen_name: names}
  end
  
  def self.scrape_selected_screen_page(screen_url)
    doc = Nokogiri::HTML(open(screen_url))
    table = doc.css("#fin-scr-res-table tbody")
    table_head = doc.css("#fin-scr-res-table thead")
    table_head_data_array = table_head.css("th").map{|e| e.text}
    table_rows = table.css("tr")
    table_row_data_array = table_rows.map {|r| r.css("td").map {|d| d.text}}
    hash = {headers: table_head_data_array, rows: table_row_data_array}
  end
end