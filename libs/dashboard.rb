class Dash
  class Dashboard
    @loaded_widgets = nil
    @available_widgets = nil
    
    def initialize
      @loaded_widgets = Hash.new
      @available_widgets = Hash.new
      self.discover
      self.endpoints
    end
    
    def registerWidget(data)
      widget_info = Hash.new
      
      if @endpoints.has_key?(data["type"])
        object = Module.const_get(@endpoints[data["type"]]).new
        object.widget_id = data["widgetId"]
        widget_info[:endpoint] = object
      end
      widget_info[:type] = data["type"]
      widget_info[:widget_id] = data["widgetId"]

      @loaded_widgets[data["type"]] = widget_info
      return nil
    end
    
    def widgets
      return @available_widgets
    end
    
    def loaded_widgets
      return @loaded_widgets
    end
    
    def discover
      base = Dir.pwd
      puts "Discovering widgets in #{base}"
      dirs = Dir.glob(base + '/widgets/*')
      widgets = Hash.new
      dirs.each do |dir|
        widgets[File.basename(dir)] = dir
      end
      @available_widgets = widgets
    end
    
    def endpoints
      base = Dir.pwd
      dirs = Dir.glob(base + '/widgets/*/feeders/endpoints/endpoints.rb')
      endpoints = Hash.new
      dirs.each do |dir|
        require dir
        widget_name = File.basename(File.dirname(File.dirname(File.dirname(dir))))
        class_name = "#{widget_name.capitalize}Endpoints"
        puts "Initing #{class_name}"
        endpoints[widget_name] = class_name
      end
      @endpoints = endpoints
    end
   
  end
end