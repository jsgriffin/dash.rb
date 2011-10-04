class TestEndpoints < Dash::Feeder 
  
  def get_data(params)
    obj = Hash.new
    obj["title"] = params[:title]
    self.send(obj)
  end
  
end