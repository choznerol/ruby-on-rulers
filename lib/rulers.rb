require 'rulers/version'
require 'rulers/routing'
require 'rulers/rulers_support'
require 'json'

module Rulers
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      env_details_tag = RulersSupport.details(summary: 'Reveal the `env` passed from Rack', content: env)

      [
          200,
          {'Content-Type' => 'text/html'},
          [text + env_details_tag]
      ]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
