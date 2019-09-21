class Object
  def self.const_missing(c)
    STDERR.puts "[AUTOLOAD] const_missing(#{c.inspect})"
    @calling_const_missing ||= {}

    return nil if @calling_const_missing[c]

    @calling_const_missing[c] = true

    # Prevent double-loading
    raise "Trying to autoload #{c} but it is already defined: #{Object.const_get(c).inspect}" if Object.const_defined?(c)

    # Actually load the file
    require Rulers.to_underscore(c.to_s)

    klass = Object.const_get(c)
    @calling_const_missing[c] = false

    klass
  end
end
