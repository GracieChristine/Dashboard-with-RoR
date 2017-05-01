require "net/http"
require "json"

Dashing.scheduler.every '1h', :first_in => 0 do |job|
    uri = URI.parse("https://todoist.com/API/v7/get_productivity_stats?token=#5cef3828bba8a90bfba732dc35634b83039746f5")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    if response.code == "200"
        result = JSON.parse(response.body)
        completed = result["completed_count"]
        karma = result["karma"]
        karmatrend = result["karma_trend"]
        Dashing.send_event 'todoist', { todoist_completed: completed, todoist_karma: karma}
    end
end
