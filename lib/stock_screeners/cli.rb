require_relative '../lib/scraper.rb'


class StockScreeners::CLI
  
  BASE_URL = "https://finance.yahoo.com/screener"
  
  def call
    puts 'Welcome, please select a stock screen.'
    display_screens
  end
  
  def create_screens
    @screens_array = Scraper.new.scrape_screeners_page(BASE_URL)
    
  end
  
  def display_screens
    screens = @screens_array[1:9]
    screens.each {|screen| puts screen}
  end
end