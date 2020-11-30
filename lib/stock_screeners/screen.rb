class StockScreeners::Screen 
  
  attr_accessor :link, :name
  
  def self.selected_screen(url)
    stocks = StockScreeners::Scraper.scrape_selected_screen_page(url)
    symbol = stocks[:headers][0]
    name = stocks[:headers][1]
    price = stocks[:headers][2]
    rows = stocks[:rows].slice(1, 9)
    rows.each_with_index {|row, i| puts "Enter #{i+1} to view a summary of #{row[1]}"}
    stocks
  end
  
end