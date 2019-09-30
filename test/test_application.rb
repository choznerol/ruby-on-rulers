require_relative 'test_helper'
# require 'pry'

class TestApp < Rulers::Application; end
class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end
end


# Test root_to Home#index
class HomeController < Rulers::Controller
  def index
    'Home#index'
  end
end
class RulersAppTest
  def test_index
    get '/'
    assert last_response.ok?
    body = last_response.body
    assert body['Home#index']
  end
end


# Test routing
class FoosController < Rulers::Controller
  def bar
    'FoosController#action'
  end
end
class RulersAppTest
  def test_routing
    get '/foos/bar'
    assert last_response.ok?
    body = last_response.body
    assert body['FoosController#action']
  end
end


# Test rendering
class TemplatesController < Rulers::Controller
  def my_template
    @my_instance_var = 42
    render 'my_template', content: 'A local var'
  end
  def missing_template
    render 'not_exist_template'
  end
end
class RulersAppTest
  def test_rendering_with_locals_and_instance_var
    begin
      f = File.new('app/views/templates/my_template.html.erb', 'w')
      f.write('<h1><%= content %></h1><p><%= @my_instance_var %></p>')
      f.close

      get '/templates/my_template'
      assert last_response.ok?
      assert last_response.body['<h1>A local var</h1>']
      assert last_response.body['<p>42</p>']
    ensure
      File.delete('app/views/templates/my_template.html.erb')
    end
  end

  def test_template_lookup_in_views_dir
    begin
      f = File.new('app/views/my_template.html.erb', 'w')
      f.write('<h1><%= content %></h1>')
      f.close

      get '/templates/my_template'
      assert last_response.ok?
      assert last_response.body['<h1>A local var</h1>']
    ensure
      File.delete('app/views/my_template.html.erb')
    end
  end

  def test_template_missing_error_message
    get '/templates/missing_template'
    assert last_response.server_error?
    body = last_response.body
    assert body['找不到'] && body['not_exist_template'] && body['已搜尋下列路徑']
  end
end
