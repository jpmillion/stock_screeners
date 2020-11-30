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
    go_back_or_restart
  end
  
  def display_selected_screen(user_input)
    self.stocks = screens[user_input].selected_screen(BASE_URL + screens[user_input].link)
  end
  
  def back_to_selected_screen
    stocks.each_with_index {|stock, i| puts "Enter #{i+1} to view a summary of #{stock.name}"}
    display_summary(get_input)
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
    puts ''
    puts "Enter your selection below: "
    user_input = gets.strip.to_i
    until user_input.between?(1, 9) do
      puts "Invalid entry, please select again."
      user_input = gets.strip.to_i
    end
    user_input - 1
  end
  
  def go_back_or_restart
    puts ''
    puts "To go back enter 'back' or to restart enter 'restart"
    puts "Enter your selection below:"
    input = gets.strip.downcase
    #while input == 'back' || input == 'restart' do
      #if input == 'back'
    case input
      
    when 'back'
        back_to_selected_screen
        go_back_or_restart
      #else
    when 'restart'
        display_screen
        self.stocks.clear
        display_selected_screen(get_input)
        display_summary(get_input)
        go_back_or_restart
      #end
    end
      #go_back_or_restart
      #puts ''
      #puts "To go back enter 'back' or to restart enter 'restart' or to quit enter'q'"
      #puts "Enter your selection below:"
      #input = gets.strip.downcase
    #end
  end
end