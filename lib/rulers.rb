require "rulers/version"
require 'json'

module Rulers
  class Application
    def call(env)
      [200, {'Content-Type' => 'text/html'},
       ["
<h1> Yay! You're on Rulers! </h1>

<br/>

<details>
  <summary> env </summary>
  <pre>#{JSON.pretty_generate(env)}</pre>
</details>
"]]
    end
  end
end