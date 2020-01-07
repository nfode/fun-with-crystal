require "http/web_socket"
require "readline"

socket = HTTP::WebSocket.new(URI.parse("ws://localhost:3000/socket?id=sender"))
socket.on_close do |message|
  puts message
  exit 1
end
spawn do
  socket.run
end
spawn do
loop do
    input = Readline.readline("Text to send \n> ")
    if input
        socket.send input
    end
end
end

sleep
