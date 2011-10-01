class Dash
  class Feeder
    @widget_id = nil
    
    def send(msg)
      puts "Sending #{msg}"
    end
    
  end
end