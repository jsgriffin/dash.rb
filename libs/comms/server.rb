require 'eventmachine'

class Dash
  class CommsServer
    def self.run      
      EventMachine::run do
        host = '0.0.0.0'
        port = 8989
        EventMachine::start_server host, port, CommsHandler
        puts "Started Comms Server"
      end
    end
    
    module CommsHandler
      def receive_data(data)
        puts "Received data: #{data}"
        send_data(data)
      end
    end
  end
end