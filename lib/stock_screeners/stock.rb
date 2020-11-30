class StockScreeners::Stock 
  
  attr_accessor :name, :summary, :link
  
  @@all = []
  
  def initialize(stock)
    stock.each {|k, v| send("#{k}=", v)}
    @@all << self
  end
  
  def self.create_stocks(url)
    stocks = StockScreeners::Scraper.scrape_selected_screen_page(url)
    #stocks = stocks.slice(1, 9)
    stocks.each {|stock| new(stock)}
    all
  end
  
  def self.all
    @@all
  end
  
  #def self.display_summary(url)
   # summary = StockScreeners::Scraper.scrape_selected_stock_summary(url)
    #summary.each {|row| puts row.join(': ')}
  #end
  
  def display_summary(url)
    self.summary =StockScreeners::Scraper.scrape_selected_stock_summary(url)
    self.summary.each {|row| puts row.join(': ')}
  end
  
end