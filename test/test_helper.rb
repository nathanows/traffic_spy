ENV["TRAFFIC_SPY_ENV"] ||= "test"
require 'traffic_spy'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'capybara'

class FeatureTest < MiniTest::Test
  include Rack::Test::Methods
  include Capybara::DSL

  def app
    TrafficSpy::Server
  end

  Capybara.app = TrafficSpy::Server
end
