class Object
  def self.const_missing(c)
    STDOUT.puts "[AUTOLOAD] const_missing(#{c.inspect})"

    # 只對從 Rulers#call 觸發的 const_missing 嘗試 auto-loading
    # 避免劫持 Rulers 與 app 以外地方的所有 const_missing，例如 Rulers 主程式中其他地方用到的第三方套件
    is_from_rulers_call_method = caller_locations.any? do |line|
      line.to_s['lib/rulers.rb'] && line.to_s['in `call\''] # e.g. lib/rulers.rb:42 in `call'
    end
    unless is_from_rulers_call_method
      STDERR.puts "[AUTOLOAD] 由於 callstack 不包含 Rulers#call，不對 #{c.inspect} 嘗試 auto-loading"
      return super(c)
    end

    @calling_const_missing ||= {}

    return nil if @calling_const_missing[c]

    @calling_const_missing[c] = true

    # Prevent double-loading
    raise "Trying to autoload #{c} but it is already defined: #{Object.const_get(c).inspect}" if Object.const_defined?(c)

    # Actually load the file
    require Rulers.to_underscore(c.to_s)

    # Raise if filename and class/module name not matched
    raise "Loaded '#{Rulers.to_underscore(c.to_s)}' but #{c} was still not defined." unless Object.const_defined?(c)

    klass = Object.const_get(c)
    @calling_const_missing[c] = false

    klass
  end
end
