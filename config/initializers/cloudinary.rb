Cloudinary.config do |config|    
  config.cloud_name = ENV["CLOUD_NAME"]   
  config.api_key = ENV["CL_API_KEY"] 
  config.api_secret = ENV["CL_API_SECRET"] 
  config.secure = true    
  config.cdn_subdomain = true  
end
