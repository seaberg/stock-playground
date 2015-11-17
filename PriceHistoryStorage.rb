require "yaml" 
require "date"

class PriceHistoryStorage
    def store_price_history(price_history)
        if price_history == nil # Nothing to store
            return
        end
        
        symbol = price_history[0][:Symbol]
        file_name = "price_history/#{symbol}"
        
        serialized = YAML::dump(price_history)
        
        File.open(file_name, 'w') { |file| file.write(serialized) }
    end
    
    def retrieve_price_history(symbol)
        file_name = "price_history/#{symbol}"
        
        begin
            serialized = File.read(file_name)
            price_history = YAML::load(serialized)
            
            # Convert to proper types
            price_history.each do |ph|
                ph[:Date] = Date.parse(ph[:Date])
                ph[:Open] = ph[:Open].to_f
                ph[:High] = ph[:High].to_f
                ph[:Low] = ph[:Low].to_f
                ph[:Close] = ph[:Close].to_f
                ph[:Volume] = ph[:Volume].to_i
                ph[:Adj_Close] = ph[:Adj_Close].to_f
            end
            
            # TODO: Make sure the price history is correctly sorted before returning it
            price_history = price_history.sort_by { |ph| ph[:Date] }.reverse!
        rescue
            return nil
        end
    end
end