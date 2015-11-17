require "yaml" 

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
            
            # TODO: Make sure the price history is correctly sorted before returning it
        rescue
            return 0
        end
    end
end