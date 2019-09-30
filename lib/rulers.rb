require 'rulers/version'
require 'rulers/routing'
require 'rulers/dependencies'
require 'rulers/util'
require 'rulers/controller'
require 'pry-byebug'

module Rulers
  class Application
    def call(env)
      # 404 for `/favicon.ico`
      return [404, headers, []] if %w[/favicon.ico robot.txt].include? env['PATH_INFO']

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)

      # Invoke MyController#my_action to get response body
      begin
        text = controller.send(act)
      rescue StandardError => e
        error_text = controller.render('500', error: e)

        return [500, headers, ["<h1> 糟糕！ <code>#{klass.name}##{act}</code> 處理請求時發生錯誤：</h1> #{error_text}"]]
      end

      [200, headers, [text]]
    end

    private

    def headers
      {'Content-Type' => 'text/html; charset=utf-8'}
    end
  end
end
