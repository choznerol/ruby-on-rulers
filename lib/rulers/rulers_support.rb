require 'json'

module RulersSupport
  def details(summary:, content:)
    "
<details>
  <summary> #{summary} </summary>
  <pre>#{JSON.pretty_generate(content)}</pre>
</details>
"
  end
end

class String
  def to_html
    gsub!('<', '&lt;').gsub!('>', '&gt;')
  end
end
