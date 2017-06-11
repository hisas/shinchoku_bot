require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/crontab.log'
set :environment, :development


every 1.days do
  rake 'twitter:tweet'
end
