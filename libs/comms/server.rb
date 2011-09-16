require 'eventmachine'
require 'em-websocket'

class Dash
  class CommsServer
    @sockets = []
    
    def self.run      
      host = '0.0.0.0'
      port = 8989
      EventMachine::WebSocket.start(:host => host, :port => port) do |socket|
        socket.onopen do
          @sockets << socket
          puts "Client connected"
        end

        socket.onmessage do |mess|
          puts "Received #{mess}"
          @sockets.each {|s| s.send mess}
        end

        socket.onclose do
          @sockets.delete socket
          puts "Client disconnected"
        end          
      end
      puts "Started Comms Server on port #{port}"
    end
  end
end