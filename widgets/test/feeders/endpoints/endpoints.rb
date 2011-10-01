class TestEndpoints < Dash::Feeder 
  
  def get_data(params)
    puts "Called!"
    self.send(params[:title])
  end
  
end