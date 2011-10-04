class Test
  class TimeDaemon < Dash::Feeder 
  
    def run
      loop {
        self.send({:title => DateTime.now.to_s})
        sleep 1
      }
    end
  
  end
end