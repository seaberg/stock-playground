require "net/http"
require "cgi"
require "json"

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
                stock_price = { :Symbol => single_item["Symbol"],
                                :Date => single_item["Date"],
                                :Open => single_item["Open"],
                                :High => single_item["High"],
                                :Low => single_item["Low"],
                                :Close => single_item["Close"],
                                :Volume => single_item["Volume"],
                                :Adj_Close => single_item["Adj_Close"]
                }
                # The problem with adding these two is probably that the
                # new_price_history does not have correct data types.
                stock_prices << single_item
        else 
            # More than 1 item
            json["query"]["results"]["quote"].each do |item|
                stock_price = { :Symbol => item["Symbol"],
                                :Date => item["Date"],
                                :Open => item["Open"],
                                :High => item["High"],
                                :Low => item["Low"],
                                :Close => item["Close"],
                                :Volume => item["Volume"],
                                :Adj_Close => item["Adj_Close"]
                }
                stock_prices << stock_price
            end
        return stock_prices
        end
    end
end