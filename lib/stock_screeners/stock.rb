class StockScreeners::Stock 
  
  #@@all
  
  #def self.create_stocks(url)
   # stocks = StockScreeners::Scraper.scrape_selected_screen_page(url)
    #stocks.each {|stock| new(stock)}
    #all
  #end
  
  #def self.all
   # @@all
  #end
  
  def self.display_summary(url)
    summary = StockScreeners::Scraper.scrape_selected_stock_summary(url)
    summary.each {|row| puts row.join(': ')}
  end
  
end