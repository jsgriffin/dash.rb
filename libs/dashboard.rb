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
   
  end
end