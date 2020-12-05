class StockScreeners::Screen 
  
  attr_accessor :link, :name, :stocks
  
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
  
  def selected_screen(url)
    self.stocks = StockScreeners::Stock.create_stocks(url) if !self.stocks
  end
end