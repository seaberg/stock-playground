require "date"
require_relative "PriceHistoryStorage"
require_relative "StockFetcher"

# Fetch symbol history for x days back
history_length = 365
# 1. Loop over list of symbols to retrieve prices for
stockholm_large_cap_symbols = ["AAK.ST", "ABB.ST", "AOI.ST", "ALFA.ST", "ASSA-B.ST", "AZN.ST", "ATCO-B.ST"]

price_history_storage = PriceHistoryStorage.new

stockholm_large_cap_symbols.each do |symbol|
    # 2. Check if there are any historical prices available, if there is not: retrieve prices as far back as needed
    price_history = price_history_storage.retrieve_price_history(symbol)
    
    if price_history == 0
        # no price history found, retrieve prices as far back as history_length
        stock_fetcher = StockFetcher.new
        
        start_date = Date.today - history_length
        end_date = Date.today
        
        price_history = stock_fetcher.fetch_price(symbol, start_date, end_date)
        price_history_storage.store_price_history(price_history)
        
    else
        # 3. Compare historical prices with todays date, if there might be new prices available, try to fetch them with StockFetcher
        # 4. If we found any new prices, insert them into the storage
    end
end
