require 'json'

module RulersSupport
  def self.details(summary:, content:)
    "
<details>
  <summary> #{summary} </summary>
  <pre>#{JSON.pretty_generate(content)}</pre>
</details>
"
  end
end