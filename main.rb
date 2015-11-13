require_relative "StockFetcher"

sf = StockFetcher.new

stock_prices = sf.fetch_price("AAK.ST", "2015-10-01", "2015-10-31")

puts stock_prices