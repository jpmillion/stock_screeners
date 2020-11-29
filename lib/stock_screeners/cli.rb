require_relative './scraper.rb'
require 'nokogiri'

class StockScreeners::CLI
  
  BASE_URL = "https://finance.yahoo.com/screener"
  
  def call
    puts 'Welcome, please select a stock screen.'
    display_screens
    user_input = gets.strip.to_i
    until user_input.between?(1..9) do
      puts "Invalid Entry, please select again."
      user_input = gets.strip.to_i
    end
  end
  
  def create_screens
    screens = StockScreeners::Scraper.scrape_screeners_page(BASE_URL)
    screens.each {|screen| StockScreeners::Screen.new}
  end
  
  def display_screens
    screens = StockScreeners::Scraper.scrape_screeners_page(BASE_URL)
    screens.each_with_index {|screen, i| puts "Enter #{i+1} to select #{screen}"}
  end
  
  def display_selected_screen(screen)
    StockScreeners::Scaper.scrape_selected_screen_page(BASE_URL + screen.url)
    
  end
end