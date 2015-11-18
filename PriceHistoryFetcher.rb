require "date"
require_relative "PriceHistoryStorage"
require_relative "StockFetcher"

# Fetch symbol history for x days back
history_length = 30

stockholm_large_cap_symbols = ["AAK.ST", "ABB.ST", "AOI.ST", "ALFA.ST", "ASSA-B.ST", "AZN.ST", "ATCO-B.ST"]

price_history_storage = PriceHistoryStorage.new
stock_fetcher = StockFetcher.new

# Loop over list of symbols to retrieve prices for
stockholm_large_cap_symbols.each do |symbol|
    # Check if there are any historical prices available, if there is not, retrieve prices as far back as needed
    price_history = price_history_storage.retrieve_price_history(symbol)
    
    if price_history == nil # no price history found, retrieve prices as far back as history_length
        start_date = Date.today - history_length
        end_date = Date.today
        
        price_history = stock_fetcher.fetch_price(symbol, start_date, end_date)
        price_history_storage.store_price_history(price_history)
    else # We have historical prices, retrieve new data
        if Date.today > price_history[0][:Date]
            # Fetch data from last stored value until today
            start_date = price_history[0][:Date] + 1
            end_date = Date.today
            
            new_price_history = stock_fetcher.fetch_price(symbol, start_date, end_date)
            
            # If we found any new prices, insert them into the storage
            if new_price_history != nil
                # Debug
                puts "new_price_history"
                puts new_price_history
                puts "price_history"
                puts price_history
                
                price_history << new_price_history
                price_history_storage = PriceHistoryStorage.new
                price_history_storage.store_price_history(price_history)
            end
        end
    end
end
