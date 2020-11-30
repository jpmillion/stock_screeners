class StockScreeners::Screen 
  
  attr_accessor :link, :name, :stocks
  #@stocks = []
  @@all = []
  
  def initialize(screen_hash)
    screen_hash.each {|k, v| send("#{k}=", v)}
    @@all << self
  end
  
  def self.create_screens(url)
    screens = StockScreeners::Scraper.scrape_screeners_page(url)
    screens.each {|screen| new(screen)}
    all
  end
  
  def self.all
    @@all
  end
  
  #def self.selected_screen(url)
   # stocks = StockScreeners::Scraper.scrape_selected_screen_page(url)
    #symbol = stocks[:headers][0]
    #name = stocks[:headers][1]
    #price = stocks[:headers][2]
    #rows = stocks[:rows].slice(1, 9)
    #rows.each_with_index {|row, i| puts "Enter #{i+1} to view a summary of #{row[1]}"}
    #stocks
  #end
  
  def selected_screen(url)
    self.stocks = StockScreeners::Stock.create_stocks(url)
    stocks.each_with_index {|stock, i| puts "Enter #{i+1} to view a summary of #{stock.name}"}
  end
end