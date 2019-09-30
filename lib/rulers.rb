require 'rulers/version'
require 'rulers/routing'
require 'rulers/dependencies'
require 'rulers/util'
require 'rulers/controller'
require 'json'

module Rulers
  class Application
    def call(env)
      # 404 for `/favicon.ico`
      return [404, { 'Content-Type' => 'text/html' }, []] if %w[/favicon.ico robot.txt].include? env['PATH_INFO']

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)

      # Invoke MyController#my_action to get response body
      begin
        text = controller.send(act)
      rescue StandardError => e
        errorDetails = Rulers.details(summary: e.inspect.to_html,
                               content: "Callstack: <br><br> #{e.backtrace.join('<br>')}")

        return [
            500,
            { 'Content-Type' => 'text/html; charset=utf-8' },
            ["<h1> 糟糕！ <code>#{klass.name}##{act}</code> 處理請求時發生錯誤：</h1> #{errorDetails}"]
        ]
      end

      env_details_tag = Rulers.details(summary: 'Reveal the `env` passed from Rack', content: env)

      [
          200,
          {'Content-Type' => 'text/html; charset=utf-8'},
          [text + env_details_tag]
      ]
    end
  end
end
