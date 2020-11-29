class StockScreeners::Stock 
  
  def self.display_summary(url)
    summary = StockScreeners::Scraper.scrape_selected_stock_summary(url)
    summary.each {|row| puts row.join(': ')}
  end
  
end