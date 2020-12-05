
class StockScreeners::CLI
  
  SCREENER_URL = "https://finance.yahoo.com/screener"
  BASE_URL = "https://finance.yahoo.com"
  
  def call
    puts 'Welcome, please select a stock screen.'
    get_screens
    puts_screens
    get_selected_screen
    puts_selected_screen
    get_stock_summary
    puts_stock_summary
    go_back_or_restart
  end

  def get_screens
    @screens = StockScreeners::Screen.create_screens(SCREENER_URL) if !@screens
  end

  def puts_screens 
    @screens.each_with_index {|screen, i| puts "Enter #{i+1} to select #{screen.name}"}
  end
  
  def get_selected_screen
    screen = StockScreeners::Screen.all[screen_index]
    @stocks = screen.selected_screen(BASE_URL + screen.link) 
  end

  def puts_selected_screen
    @stocks.each_with_index {|stock, i| puts "Enter #{i+1} to view a summary of #{stock.name}"}
  end
  
  def get_stock_summary
    stock = @stocks[stock_index]
    @table_summary = stock.get_summary(BASE_URL + stock.link) if !stock.summary 
  end

  def puts_stock_summary
    @table_summary.each {|row| puts row.join(': ')}
  end
  
  def get_selection
    puts ''
    puts "Enter your selection below: "
    gets.strip.to_i
  end

  def screen_index
    selection = get_selection
    until selection.between?(1, @screens.count) do
      puts "Invalid entry, try again."
      selection = get_index
    end
    selection - 1
  end

  def stock_index
    selection = get_selection
    until selection.between?(1, @stocks.count) do
      puts "Invalid entry, try again."
      selection = get_index
    end
    selection - 1
  end
  
  def go_back_or_restart
    puts ''
    puts "To go back enter 'back' or to restart enter 'restart'or enter 'q' to quit"
    puts "Enter your selection below:"
    input = gets.strip.downcase
  
    case input
      
    when 'back'
        puts_selected_screen
        get_stock_summary
        puts_stock_summary  
        go_back_or_restart
        
    when 'restart'
        call
    end
  end
end