require_relative 'test_helper'

class TestApp < Rulers::Application
end
class FoosController < Rulers::Controller
  def bar
    'FoosController#action'
  end
end
class HomeController < Rulers::Controller
  def index
    'Home#index'
  end
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
    assert body['Home#index']
  end

  def test_
    get '/foos/bar'
    assert last_response.ok?
    body = last_response.body
    assert body['FoosController#action']
  end
end
