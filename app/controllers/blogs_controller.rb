class BlogsController < ApplicationController
  def index
  end

  def show
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
    slug = params[:slug].gsub /[^0-9A-Za-z\-]/, "_"
    @rendered_html = markdown.render(File.read("app/views/blogs/#{slug}.md"))
  rescue Errno::ENOENT
    render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
  end
end
