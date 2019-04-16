require 'pry'

class Application 
  
  @@items = [] 
  
  def call(env)
    resp = Rack::Response.new 
    req = Rack::Request.new(env)
 
    if req.path.start_with?("/items/")
      item_input = req.path.split("/items/").last
      
      selected_item = @@items.select{|item| item.name == item_input}.first
      if selected_item != nil 
        resp.write selected_item.price
      else 
        resp.status = 400
        resp.write "Item not found"
      end 
    else 
      resp.write "Route not found"
      resp.status = 404 
    end 
    resp.finish 
  end 
end 