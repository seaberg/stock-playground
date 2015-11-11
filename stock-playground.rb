require "net/http"
require "cgi"
require "json"

# http://query.yahooapis.com/v1/public/yql?q=select * from geo.places where text="sunnyvale, ca"
# url = "http://query.yahooapis.com/v1/public/yql?q=select * from geo.places where text=\"sunnyvale, ca\""

base_url = "https://query.yahooapis.com/v1/public/yql?q="
url_end = "&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json"

ticker = "ABB.ST"
start_date = "2009-09-11"
end_date = "2009-10-11"

query = CGI.escape("select * from yahoo.finance.historicaldata where symbol = \"#{ticker}\" and startDate = \"#{start_date}\" and endDate = \"#{end_date}\"")
complete_url = "#{base_url}#{query}#{url_end}"

resp = Net::HTTP.get_response(URI.parse(complete_url))
resp_text = resp.body

json = JSON.parse(resp_text)

# puts JSON.pretty_generate(json)

json["query"]["results"]["quote"].each do |item|
    puts "Date: #{item["Date"]}"
    puts "Close: #{item["Close"]}"
end
