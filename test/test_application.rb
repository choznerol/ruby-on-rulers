require_relative 'test_helper'

class TestApp < Rulers::Application
end
class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_index
    get '/'
    assert last_response.ok?
    body = last_response.body
    assert body["You're on Rulers"]
  end

  def test_random_url
    get '/foo/bar/bez'
    assert last_response.ok?
    assert last_response.body["You're on Rulers"]
  end
end
