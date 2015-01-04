require_relative 'test_helper'

module TrafficSpy

  class SeverTest < MiniTest::Test
    include Rack::Test::Methods
    include Capybara::DSL

    def app
      TrafficSpy::Server
    end

    Capybara.app = TrafficSpy::Server
    #
    def teardown
      DB[:urls].rollback
      DB[:sources].rollback
      DB[:referrals].rollback
      DB[:events].rollback
      DB[:user_agents].rollback
      DB[:resolutions].rollback
      DB[:payloads].rollback
    end
    #
    # def teardown
    #   Rollback
    # end

    def teardown
      # DB.transaction do
        # (:rollback => :always)
        # raise Sequel::
      # end
      #
      # DB.transaction(:rollback => :always) do
      #   DB[:sources].update
      # end
      # DB.transaction(:rollback => :always) do
      #   DB[:referrals].update
      # end
      # DB.transaction(:rollback => :always) do
      #   DB[:events].update
      # end
      # DB.transaction(:rollback => :always) do
      #   DB[:user_agents].update
      # end
      # endDC.transaction(:rollback => :always) do
      #   DB[:resolutions].update
      # end
      # DB.transaction(:rollback => :always) do
      #   DB[:payloads].update
      # end
        # DB[:urls].replace
        # DB[:sources].replace
        # DB[:referrals].replace
        # DB[:events].replace
        # DB[:user_agents].replace
        # DB[:resolutions].replace
        # DB[:payloads].replace
      # end
    end

    def test_can_add_a_valid_source
      post '/sources', {:identifier => "kafzjkdf", :rootUrl => "http://jumpstartflops.com"}
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
      post '/sources', {:identifier => "asldfhl", :rootUrl => "http://jumpstartlab.com"}
      post '/sources', {:identifier => "asldfhl", :rootUrl => "http://jumpstartlab.com"}
      assert_equal 403, last_response.status
    end

  end
end
