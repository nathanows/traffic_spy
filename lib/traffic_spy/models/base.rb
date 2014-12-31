module TrafficSpy

  if ENV["TRAFFIC_SPY_ENV"] == "test"
    database_file = 'db/traffic_spy-test.sqlite3'
    DB = Sequel.sqlite database_file
  else
    DB = Sequel.postgres "traffic_spy"
  end

end

#
# Require all the files within the model directory here...
#
# @example

require 'traffic_spy/models/urls'
require 'traffic_spy/models/sources'
require 'traffic_spy/models/payloads'
require 'traffic_spy/models/events'
require 'traffic_spy/models/referrals'
require 'traffic_spy/models/user_agents'
require 'traffic_spy/models/resolutions'
