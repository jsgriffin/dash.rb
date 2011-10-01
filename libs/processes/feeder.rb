class Dash
  class Feeder
    attr_accessor :widget_id
    
    def send(msg)
      puts "Sending #{msg}"
    end
        
  end
end