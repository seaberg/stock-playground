require "yaml" 

class PriceHistoryStorage
    def store_price_history(price_history)
        serialized = YAML::dump(price_history)
        
        symbol = price_history[0][:Symbol]
        file_name = "price_history/#{symbol}"
        
        File.open(file_name, 'w') { |file| file.write(serialized) }
    end
    
    def retrieve_price_history(symbol)
        file_name = "price_history/#{symbol}"
        
        serialized = File.read(file_name)
        price_history = YAML::load(serialized)
        
        puts price_history
    end
end