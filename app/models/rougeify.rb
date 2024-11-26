require 'rouge/plugins/redcarpet'

class Rougeify < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def rouge_formatter(lexer)
    Rouge::Formatters::HTMLPygments.new(Rouge::Formatters::HTML.new, css_class='codeblock')
  end
end

