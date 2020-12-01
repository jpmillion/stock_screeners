require_relative "stock_screeners/version"
require_relative "stock_screeners/cli"
require_relative "stock_screeners/scraper"
require_relative "stock_screeners/screen"
require_relative "stock_screeners/stock"
require 'nokogiri'
require 'pry'
require 'open-uri'

module StockScreeners
  class Error < StandardError; end
  # Your code goes here...
end
