require "kemal"

# Matches GET "http://host:port/"
get "/" do
  "Hello World!"
end

socket_store = {} of String => HTTP::WebSocket

# Creates a WebSocket handler.
# Matches "ws://host:port/socket"
ws "/socket" do |socket, context|
  begin
    id = context.request.query_params["id"]
    socket_store[id] = socket
    socket.send "Hello from the server"
    socket.on_message do |message|
      puts "Received message #{message}"
      socket_store.select { |k, v| k != id }
          .each do |key,value|
            puts "sending message to client with id: #{key}"
            value.send message
          end
    end
    socket.on_close do 
      puts "Closed connection with id #{id}"
      socket_store.delete(id)
    end
  rescue ex
    socket.close "Missing id parameter: #{ex.message}"
  end
end

Kemal.run
