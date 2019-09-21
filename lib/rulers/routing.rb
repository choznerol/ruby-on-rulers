module Rulers
  class Application
    def get_controller_and_action(env)
      # Root always go to HomeController#index
      return [Object.const_get('HomeController'), 'index'] if env['PATH_INFO'] === '/'

      _, ctrl, action, after =
          env["PATH_INFO"].split('/', 4)
      ctrl = ctrl.capitalize # "People"
      ctrl += "Controller" # "PeopleController"
      [Object.const_get(ctrl), action]
    end
  end
end
