require './test/test_helper'

class AddSourceTest < FeatureTest

  def teardown
    TrafficSpy::DB.from(:sources).delete
  end

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
    post '/sources', {:identifier => "asldkfhl", :rootUrl => "http://jumpstartlab.com"}
    post '/sources', {:identifier => "asldkfhl", :rootUrl => "http://jumpstartlab.com"}
    assert_equal 403, last_response.status
  end

end
