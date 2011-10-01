class Dash
  class Feeder
    attr_accessor :widget_id
    
    def send(msg)
      @client = WebSocket.new("ws://localhost:8989")
      puts "Sending #{msg}"
      object = Hash.new
      object["id"] = self.widget_id
      object["data"] = msg
      @client.send(object.to_json)
      @client.close
    end
        
  end
end