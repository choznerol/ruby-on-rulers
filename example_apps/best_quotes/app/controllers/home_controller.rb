class HomeController < Rulers::Controller
  def index
    render 'index', actions_by_controller: {
        'quotes': %w[a_quote exception]
    }
  end
end
