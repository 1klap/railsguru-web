class BlogsController < ApplicationController
  allow_unauthenticated_access

  def index
  end

  def show
    post_filename = ActiveStorage::Filename.new("#{params[:slug]}.md").sanitized
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
    @rendered_html = markdown.render(File.read("app/views/blogs/#{post_filename}"))
  rescue Errno::ENOENT
    render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
  end
end
