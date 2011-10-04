require 'daemons'

class Dash
  class ProcessServer
    attr_accessor :dashboard
    
    def self.run(dashboard) 
      this = Dash::ProcessServer.new
      this.dashboard = dashboard
      
      @client = WebSocket.new("ws://localhost:8989")

      loop {
        data = JSON.parse(@client.receive)

        if data["type"] == "register_widget"
          this.start_daemon(data["data"]["type"], data["data"]["widgetId"])
        end
      }
    end
    
    def start_daemon(widget_type, widget_id)
      options = {
        :backtrace => false,
        :multiple  => true
      }
      
      class_names = self.dashboard.daemons[widget_type]
            
      class_names.each do |class_name|
        Daemons.call(options) do
          obj = eval(class_name).new
          obj.widget_id = widget_id
          obj.run
        end
      end
    end
  end
end