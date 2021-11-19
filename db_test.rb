require './config/environment.rb' # Assuming the script is located in the root of the rails app
begin
  ActiveRecord::Base.establish_connection # Establishes connection
  ActiveRecord::Base.connection # Calls connection object
  puts "CONNECTED!" if ActiveRecord::Base.connected? 
  puts "NOT CONNECTED!" unless ActiveRecord::Base.connected?
rescue
  puts "NOT CONNECTED!"
end