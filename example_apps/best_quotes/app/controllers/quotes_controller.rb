class QuotesController < Rulers::Controller
  def a_quote
    render 'a_quote', noun: 'winking'
  end

  def exception
    raise "It's a bad one!"
  end

  def template_missing
    render 'no_exist_template'
  end
end
