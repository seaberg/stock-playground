require "net/http"
require "nokogiri"

# http://query.yahooapis.com/v1/public/yql?q=select * from geo.places where text="sunnyvale, ca"

# url = "http://query.yahooapis.com/v1/public/yql?q=select * from geo.places where text=\"sunnyvale, ca\""

url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22YHOO%22%20and%20startDate%20%3D%20%222009-09-11%22%20and%20endDate%20%3D%20%222010-03-10%22&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
resp = Net::HTTP.get_response(URI.parse(url))
resp_text = resp.body

# puts resp_text

xml_doc = Nokogiri::XML(resp_text)

# new comment