class HomeController < Rulers::Controller
  def index
    render 'index', actions_by_controller: {
        'quotes': %w[a_quote exception template_missing]
    }
  end
end
