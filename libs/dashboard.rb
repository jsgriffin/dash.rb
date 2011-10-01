class Dash
  class Dashboard
    @loadedWidgets = nil
    @availableWidgets = nil
    
    def initialize
      @loadedWidgets = Hash.new
      @availableWidgets = Hash.new
      self.discover
    end
    
    def registerWidget(data)
      @loadedWidgets[data["widgetId"]] = data["type"]
    end
    
    def widgets
      return @availableWidgets
    end
    
    def loadedWidgets
      return @loadedWidgets
    end
    
    def discover
      base = Dir.pwd
      puts "Discovering widgets in #{base}"
      dirs = Dir.glob(base + '/widgets/*')
      widgets = Hash.new
      dirs.each do |dir|
        widgets[File.basename(dir)] = dir
      end
      @availableWidgets = widgets
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
        endpoints[widget_name] = Module.const_get(class_name).new
      end
      return endpoints     
    end
   
  end
end