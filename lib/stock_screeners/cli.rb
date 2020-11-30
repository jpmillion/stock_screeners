require_relative './scraper.rb'
require 'nokogiri'
require 'pry'

class StockScreeners::CLI
  
  attr_accessor :screens, :stocks, :first_display
  
  SCREENER_URL = "https://finance.yahoo.com/screener"
  BASE_URL = "https://finance.yahoo.com"
  
  def call
    puts 'Welcome, please select a stock screen.'
    get_and_display_screens
    display_selected_screen(get_input)
    display_summary(get_input)
    back_to_selected_screen if start_over?
    display_screen if start_over?
  end
  
  def display_selected_screen(user_input)
    self.stocks = screens[user_input].selected_screen(BASE_URL + screens[user_input].link)
  end
  
  def back_to_selected_screen
    stocks.each_with_index {|stock, i| puts "Enter #{i+1} to view a summary of #{stock.name}"}
  end
  
  def get_and_display_screens
    self.screens = StockScreeners::Screen.create_screens(SCREENER_URL)
    screens.each_with_index {|screen, i| puts "Enter #{i+1} to select #{screen.name}"}
  end
  
  def display_screen 
    screens.each_with_index {|screen, i| puts "Enter #{i+1} to select #{screen.name}"}
  end
  
  
  def display_summary(user_input)
    self.stocks[user_input].display_summary(BASE_URL + stocks[user_input].link)
  end
  
  def get_input 
    puts "Enter your selection below: "
    user_input = gets.strip.to_i
    until user_input.between?(1, 9) do
      puts "Invalid entry, please select again."
      user_input = gets.strip.to_i
    end
    user_input - 1
  end
  
  def start_over?
    puts ''
    puts "To go back enter 'y'"
    puts "Enter your selection here: #{user_input = gets.strip.downcase}"
    true if user_input == 'y'
  end
end