require 'rulers/version'
require 'rulers/rulers_support'
require 'json'

module Rulers
  class Application
    def call(env)
      [200, {'Content-Type' => 'text/html'},
       ["
<h1> Yay! You're on Rulers! </h1>

<br/>
#{RulersSupport.details(summary: 'Reveal the `env` passed from Rack', content: env)}
"]]
    end
  end
end