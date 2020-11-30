require_relative './scraper.rb'
require 'nokogiri'
require 'pry'

class StockScreeners::CLI
  
  attr_accessor :screens, :stocks
  
  SCREENER_URL = "https://finance.yahoo.com/screener"
  BASE_URL = "https://finance.yahoo.com"
  
  def call
    puts 'Welcome, please select a stock screen.'
    display_screens
    user_input = select_screen
    #user_input = gets.strip.to_i
    #until user_input.between?(1, 9) do
     # puts "Invalid entry, please select again."
      #user_input = gets.strip.to_i
    #end
    display_selected_screen(user_input-1)
    user_input = gets.strip.to_i
    until user_input.between?(1, 9) do
      puts "Invalid entry, please select again."
      user_input = gets.strip.to_i
    end
    display_summary(user_input-1)
  end
  
  def display_selected_screen(user_input)
    screen_url = screens[user_input][:link]
    self.stocks = StockScreeners::Screen.selected_screen(BASE_URL + screen_url)
  end
  
  def display_screens
    self.screens = StockScreeners::Scraper.scrape_screeners_page(SCREENER_URL)
    screens.each_with_index {|screen, i| puts "Enter #{i+1} to select #{screen[:name]}"}
  end
  
  def display_summary(user_input)
    summary_url = stocks[:quotes][user_input]
    StockScreeners::Stock.display_summary(BASE_URL + summary_url)
  end
  
  def select_screen 
    user_input = gets.strip.to_i
    until user_input.between?(1, 9) do
      puts "Invalid entry, please select again."
      user_input = gets.strip.to_i
    end
    user_input
  end
end