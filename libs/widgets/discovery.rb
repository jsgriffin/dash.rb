class Dash
  class WidgetDiscovery
    
    def self.discover
      base = Dir.pwd
      puts "Discovering widgets in #{base}"
      dirs = Dir.glob(base + '/widgets/*')
      widgets = Hash.new
      dirs.each do |dir|
        widgets[File.basename(dir)] = dir
      end
      return widgets
    end 
    
  end
end