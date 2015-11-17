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
        
        # Debug
        # puts json["query"]["count"]
        # puts json["query"]["results"]["quote"]
        
        if json["query"]["count"].to_i > 0
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