module Rulers
  class Application
    def get_controller_and_action(env)
      _, ctrl, action, after =
          env["PATH_INFO"].split('/', 4)
      ctrl = ctrl.capitalize # "People"
      ctrl += "Controller" # "PeopleController"
      [Object.const_get(ctrl), action]
    end
  end
end
