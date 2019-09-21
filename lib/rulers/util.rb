require 'json'

module Rulers
  def self.details(summary:, content:)
    "
<details>
  <summary> #{summary} </summary>
  <pre>#{JSON.pretty_generate(content)}</pre>
</details>
"
  end

  def self.to_underscore(string)
    string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
  end
end

class String
  def to_html
    gsub!('<', '&lt;').gsub!('>', '&gt;')
  end
end
