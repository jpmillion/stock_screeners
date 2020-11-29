require_relative './scraper.rb'
require 'nokogiri'

class StockScreeners::CLI
  
  attr_accessor :screens
  
  SCREENER_URL = "https://finance.yahoo.com/screener"
  BASE_URL = "https://finance.yahoo.com"
  
  def call
    puts 'Welcome, please select a stock screen.'
    display_screens
    user_input = gets.strip.to_i
    until user_input.between?(1, 5) do
      puts "Invalid Entry, please select again."
      user_input = gets.strip.to_i
    end
    display_selected_screen(user_input-1)
  end
  
  def display_selected_screen(user_input)
    #screens = StockScreeners::Scraper.scrape_screeners_page(BASE_URL)
    screen_url = screens[:screen_link][user_input]
    screen = StockScreeners::Scraper.scrape_selected_screen_page(BASE_URL + screen_url)
    #puts screen[:headers].join(' ')
    #screen[:rows].each {|row| puts row.join(' ')}
    symbol = screen[:headers][0]
    name = screen[:headers][1]
    price = screen[:headers][2]
    #screen[:rows].each_with_index {|row, i| puts "Enter #{i+1} to view a summary of #{row[1]}"}
    rows = screen[:rows].slice(1, 9)
    rows.each_with_index {|row, i| puts "Enter #{i+1} to view a summary of #{row[1]}"}
  end
  
  def display_screens
    self.screens = StockScreeners::Scraper.scrape_screeners_page(SCREENER_URL)
    screens[:screen_name].each_with_index {|screen, i| puts "Enter #{i+1} to select #{screen}"}
  end
  
  #def display_selected_screen(screen)
    #::Scaper.scrape_selected_screen_page(BASE_URL + screen.url)
    
  #end
end