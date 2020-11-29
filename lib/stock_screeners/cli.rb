require_relative './scraper.rb'
require 'nokogiri'

class StockScreeners::CLI
  
  BASE_URL = "https://finance.yahoo.com/screener"
  
  def call
    puts 'Welcome, please select a stock screen.'
    display_screens
  end
  
  def create_screens
    #@screens_array = 
    StockScreeners::Scraper.scrape_screeners_page(BASE_URL)
    #@screens_array.slice(1, 9)
  end
  
  def display_screens
    screens = create_screens
    screens.each {|screen| puts screen}
  end
end