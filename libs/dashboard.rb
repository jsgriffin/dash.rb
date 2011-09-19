class Dash
  class Dashboard
    @loadedWidgets = nil
    @availableWidgets = nil
    
    def initialize
      self.discover
      @loadedWidgets = Hash.new
      @availableWidgets = Hash.new
    end
    
    def registerWidget(data)
      @loadedWidgets[data["widgetId"]] = data["type"]
    end
    
    def widgets
      return @availableWidgets
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