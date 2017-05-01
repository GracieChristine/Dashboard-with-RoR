require "net/http"
require "json"

todoist_token = '5cef3828bba8a90bfba732dc35634b83039746f5'

Dashing.scheduler.every '1h', :first_in => 0 do |job|

    item_url_string  = 'https://todoist.com/API/v7/sync?token=' + todoist_token + '&resource_types=["items"]&sync_token=\'*\''
    encoded_item_url_string = URI.encode(item_url_string)

    item_uri = URI.parse(encoded_item_url_string)
    http = Net::HTTP.new(item_uri.host, item_uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(item_uri.request_uri)
    response = http.request(request)

    if response.code == "200"
        result = JSON.parse(response.body)
        items = result['items']
        items_array = Array[]
        items.each do |st|
             items_array.push(st['content'])
        end
        Dashing.send_event('todoist', {items: items_array})
    else
        puts response.code
        puts response.body
        puts item_url_string
    end
end
