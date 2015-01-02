require 'spec_helper'
require 'rack/test'

module TrafficSpy
  describe "traffic_spy" do
    include Rack::Test::Methods

    def app
      TrafficSpy::AppServer
    end

# context "when posting a source" do

  it "posts a source" do
    post '/sources', { :identifier => "tester", :rootUrl => "http://www.tester.com" }
    expect(last_response.status).to be 200
  end

  it "doesn't post a source" do
    2.times { post '/sources', { :identifier => "tester", :rootUrl => "http://www.tester.com" } }
    expect(last_response.status).to be 403
  end

  it "doesn't post a source when missing parameters" do
    post '/sources'
    expect(last_response.status).to be 400
  end
end
