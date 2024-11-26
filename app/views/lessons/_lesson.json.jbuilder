json.extract! lesson, :id, :title, :slug, :summary, :content_text, :content_html, :published, :published_at, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
