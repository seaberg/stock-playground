require "net/http"
require "cgi"
require "json"
require "date"

class StockFetcher
    def fetch_price(symbol, start_date, end_date)
        base_url = "https://query.yahooapis.com/v1/public/yql?q="
        url_end = "&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json"
        
        query = CGI.escape("select * from yahoo.finance.historicaldata where symbol = \"#{symbol}\" and startDate = \"#{start_date}\" and endDate = \"#{end_date}\"")
        complete_url = "#{base_url}#{query}#{url_end}"
        
        resp = Net::HTTP.get_response(URI.parse(complete_url))
        resp_text = resp.body
        
        json = JSON.parse(resp_text)
       
        stock_prices = []
        
        if json["query"]["count"].to_i == 0
            # No prices found, nothing to do
            return 
        elsif json["query"]["count"].to_i == 1
                single_item = json["query"]["results"]["quote"]
                stock_price = extract_stock_price(single_item)
                stock_prices << stock_price
        else 
            # More than 1 item
            json["query"]["results"]["quote"].each do |item|
                stock_price = extract_stock_price(item)
                stock_prices << stock_price
            end
        return stock_prices
        end
    end
    
    def extract_stock_price(item)
        stock_price = { :Symbol => item["Symbol"],
                        :Date => Date.parse(item["Date"]),
                        :Open => item["Open"].to_f,
                        :High => item["High"].to_f,
                        :Low => item["Low"].to_f,
                        :Close => item["Close"].to_f,
                        :Volume => item["Volume"].to_f,
                        :Adj_Close => item["Adj_Close"].to_f
        }
        return stock_price
    end
end