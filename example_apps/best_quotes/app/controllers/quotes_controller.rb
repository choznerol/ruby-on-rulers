class QuotesController < Rulers::Controller
  def a_quote
    @noun = 'winking'
    render 'a_quote'
  end

  def exception
    raise "It's a bad one!"
  end

  def template_missing
    render 'no_exist_template'
  end
end
