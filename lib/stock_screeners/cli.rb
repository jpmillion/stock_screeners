require_relative './scraper.rb'
require 'nokogiri'

class StockScreeners::CLI
  
  attr_accessor :screens, :stocks
  
  SCREENER_URL = "https://finance.yahoo.com/screener"
  BASE_URL = "https://finance.yahoo.com"
  
  def call
    puts 'Welcome, please select a stock screen.'
    display_screens
    user_input = gets.strip.to_i
    until user_input.between?(1, 9) do
      puts "Invalid entry, please select again."
      user_input = gets.strip.to_i
    end
    display_selected_screen(user_input-1)
    user_input = gets.strip.to_i
    until user_input.between?(1, 9) do
      puts "Invalid entry, please select again."
      user_input = gets.strip.to_i
    end
    display_summary(user_input-1)
  end
  
  def display_selected_screen(user_input)
    screen_url = screens[:screen_link][user_input]
    self.stocks = StockScreeners::Screen.selected_screen(BASE_URL + screen_url)
  end
  
  def display_screens
    #self.screens = StockScreeners::Scraper.scrape_screeners_page(SCREENER_URL)
    #screens[:screen_name].each_with_index {|screen, i| puts "Enter #{i+1} to select #{screen}"}
    self.screens = StockScreeners::Screen.new(SCREENER_URL)
  end
  
  def display_summary(user_input)
    summary_url = stocks[:quotes][user_input]
    StockScreeners::Stock.display_summary(BASE_URL + summary_url)
  end
end