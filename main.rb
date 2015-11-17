require_relative "StockFetcher"
require_relative "PriceHistoryStorage"

# sf = StockFetcher.new

# stock_prices = sf.fetch_price("AAK.ST", "2015-10-01", "2015-10-31")

phs = PriceHistoryStorage.new
# phs.store_price_history(stock_prices)
price_history = phs.retrieve_price_history("AAK.ST")
puts price_history
