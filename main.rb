require_relative "StockFetcher"
require_relative "PriceHistoryStorage"

sf = StockFetcher.new

stock_prices = sf.fetch_price("AAK.ST", "2015-10-01", "2015-10-31")

# puts stock_prices

phs = PriceHistoryStorage.new
phs.store_price_history(stock_prices)
phs.retrieve_price_history("AAK.ST")