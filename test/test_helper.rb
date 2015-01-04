ENV["RACK_ENV"] = "test"
ENV["TRAFFIC_SPY_ENV"] ||= "test"
require_relative '../lib/traffic_spy'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'bundler'
require 'sinatra'
require 'rack/test'
require 'capybara'
require 'nokogiri'
Bundler.require

require_relative '../lib/traffic_spy.rb'
# $:.unshift File.expand_path("../../lib", __FILE__)
#
# module TrafficSpy
#
#   class FeatureTest < MiniTest::Test
#     include Rack::Test::Methods
#     include Capybara::DSL
#
#   def app
#     TrafficSpy::Server
#   end
#
#   def
#     Sequel::Rollback
#
#   Capybara.app = TrafficSpy::Server
# end
