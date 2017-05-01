require 'net/http'
require 'uri'
require 'json'

server = "http://api.forismatic.com"

Dashing.scheduler.every '30m', :first_in => 0 do |job|

	url = URI.parse("#{server}/api/1.0/?method=getQuote&key=&format=json&lang=en")
	req = Net::HTTP::Get.new(url.to_s)
	res = Net::HTTP.start(url.host, url.port) {|http|
		http.request(req)
	}

	# Convert to JSON
	j = JSON[res.body]

	# Update the dashboard
	Dashing.send_event("quote", { text: j['quoteText'], moreinfo: j['quoteAuthor'] })

end
