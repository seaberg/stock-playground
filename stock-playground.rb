require "net/http"
require "nokogiri"
require "cgi"

# http://query.yahooapis.com/v1/public/yql?q=select * from geo.places where text="sunnyvale, ca"

# url = "http://query.yahooapis.com/v1/public/yql?q=select * from geo.places where text=\"sunnyvale, ca\""

base_url = "https://query.yahooapis.com/v1/public/yql?q="
url_end = "&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"

ticker = "YHOO"
start_date = "2009-09-11"
end_date = "2009-10-11"

query = CGI.escape("select * from yahoo.finance.historicaldata where symbol = \"#{ticker}\" and startDate = \"#{start_date}\" and endDate = \"#{end_date}\"")
complete_url = "#{base_url}#{query}#{url_end}"

resp = Net::HTTP.get_response(URI.parse(complete_url))
resp_text = resp.body

xml_doc = Nokogiri::XML(resp_text)

puts xml_doc