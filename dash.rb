require 'rubygems'
require 'libs/dashboard'
require 'libs/frontend/server'
require 'libs/comms/server'
require 'libs/processes/server'
require 'libs/processes/feeder'
require 'libs/comms/web-socket-client/lib/web_socket'

begin
  require 'fastthread'
rescue LoadError
ensure
  require 'thread'
end

@dashboard = Dash::Dashboard.new

# Kick it all off
frontend = Thread.new {Dash::FrontendServer.run(@dashboard)}
comms = Thread.new {Dash::CommsServer.run(@dashboard)}
process = Thread.new {Dash::ProcessServer.run(@dashboard)}

# Sinatra grabs all Ctrl-C requests, so wait for it to finish first, 
# then shut everything else down
frontend.join
comms.exit
process.exit