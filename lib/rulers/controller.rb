require 'erubis'

module Rulers
  class Controller
    class TemplateNotFoundError < StandardError; end

    def initialize(env)
      @env = env
    end

    def env
      @env
    end

    def render(view_name, locals = {})
      filepath = template_filepath(view_name)

      if filepath.blank?
        raise TemplateNotFoundError, "找不到 #{view_name.inspect} 的 template，已搜尋下列路徑：\n#{possible_template_filepath(view_name).join("\n")}"
      end

      template = File.read filepath
      eruby = Erubis::Eruby.new(template)
      ivar = self.instance_variables.map{|k| [k, self.instance_variable_get(k)]}.to_h
      eruby.result locals.merge(env: env).merge(ivar)
    end

    private

    def possible_template_filepath(view_name)
      filename = "#{view_name}.html.erb"
      [
        File.join('app', 'views', controller_name, filename),
        File.join('app', 'views', filename),
        File.join(File.dirname(__FILE__), 'views', controller_name, filename),
        File.join(File.dirname(__FILE__), 'views', filename),
      ]
    end

    def template_filepath(view_name)
      possible_template_filepath(view_name).each do |path|
        return path if File.exist? path
      end

      nil
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub /Controller$/, ""
      Rulers.to_underscore klass
    end
  end
end