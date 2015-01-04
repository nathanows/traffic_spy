require_relative 'test_helper'

module TrafficSpy

  class SeverTest < MiniTest::Test
    include Rack::Test::Methods
    include Capybara::DSL

    def app
      TrafficSpy::Server
    end

    Capybara.app = TrafficSpy::Server

    def teardown
      DB[:urls].delete
      DB[:sources].delete
      DB[:referrals].delete
      DB[:events].delete
      DB[:user_agents].delete
      DB[:resolutions].delete
      DB[:payloads].delete
    end

    # def teardown
    #   Sequel::Rollback
    # end

    def test_can_add_a_valid_source
      post '/sources', {:identifier => "kaaskdfjlsdf", :rootUrl => "http://jumpstartlab.com"}
      assert_equal 200, last_response.status
    end

    def test_ok_response_from_root
      get '/'
      assert_equal 200, last_response.status
    end

    def test_breaks_if_not_enough_params
      post '/sources', {:identifier => "jumpstartlab"}
      assert_equal 400, last_response.status
    end

    def test_breaks_if_duplicate_entries
      2.times.post '/sources', {:identifier => "asldkfhl", :rootUrl => "http://jumpstartlab.com"}
      # post '/sources', {:identifier => "asldkfhl", :rootUrl => "http://jumpstartlab.com"}
      assert_equal 403, last_response.status
    end

  end
end
