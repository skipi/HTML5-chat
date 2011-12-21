require 'em-websocket'

sockets = []
EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
  ws.onopen {
    sockets.push(ws)
    puts "Number of sockets connected: #{sockets.length}"
  }
  ws.onmessage { |msg|
    sockets.each do |socket|
      if socket == ws
        msg = "<b>#{msg}</b>"
      else
        msg = " #{msg}"
      end
      socket.send msg
    end
  }
  ws.onclose {
    sockets.delete(ws)
    puts "Number of sockets connected: #{sockets.length}"
  }
end