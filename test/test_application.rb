require_relative 'test_helper'
# require 'pry'

class TestApp < Rulers::Application
end
class HomeController < Rulers::Controller
  def index
    'Home#index'
  end
end
class FoosController < Rulers::Controller
  def bar
    'FoosController#action'
  end
end
class TemplatesController < Rulers::Controller
  def my_template
    render 'my_template', content: 'A local var'
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

  def test_routing
    get '/foos/bar'
    assert last_response.ok?
    body = last_response.body
    assert body['FoosController#action']
  end

  def test_rendering
    begin
      f = File.new('app/views/templates/my_template.html.erb', 'w')
      f.write('<h1><%= content %></h1>')
      f.close

      get '/templates/my_template'
      assert last_response.ok?
      assert last_response.body['<h1>A local var</h1>']
    ensure
      File.delete('app/views/templates/my_template.html.erb')
    end
  end
end
