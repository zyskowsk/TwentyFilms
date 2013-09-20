uri = URI.parse('http://localhose:3000')
REDIS = Redis.new(
  :host => uri.host, 
  :port => uri.port, 
  :password => uri.password
)