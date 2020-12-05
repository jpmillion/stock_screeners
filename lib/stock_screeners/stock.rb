class StockScreeners::Stock 
  
  attr_accessor :name, :summary, :link
  
  @@all = []
  
  def initialize(stock)
    stock.each {|k, v| send("#{k}=", v)}
    @@all << self
  end
  
  def self.create_stocks(url)
    stocks = StockScreeners::Scraper.scrape_selected_screen_page(url)
    stocks.map {|stock| new(stock)}
  end
  
  def self.all
    @@all
  end
  
  def get_summary(url)
    self.summary = StockScreeners::Scraper.scrape_selected_stock_summary(url) if !self.summary
  end
  
end