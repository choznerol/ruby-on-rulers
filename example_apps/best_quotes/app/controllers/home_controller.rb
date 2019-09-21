require_relative './quotes_controller'

class HomeController < Rulers::Controller
  def index
    "
    <h1> 首頁 </h1>
    <ul>
      #{controller_action_paths('quotes', 'a_quote', 'exception').join()}
    </ul>
    "
  end

  private
    def controller_action_paths(ctrl, *actions)
      actions.map { |m| "<li> <a href='/#{ctrl}/#{m}'> /#{ctrl}/#{m} </a> </li>" }
    end
end
