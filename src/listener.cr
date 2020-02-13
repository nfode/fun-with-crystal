require "http/web_socket"

socket = HTTP::WebSocket.new(URI.parse("ws://localhost:3000/socket?id=listener"))

socket.on_message do |message|
  puts message
end

socket.on_close do |message|
  puts message
  exit 1
end

socket.run
