require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  describe "GET /blog" do
    it "returns http success" do
      get "/blog"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /blog/:slug" do
    it "returns http success for valid urls" do
      get "/blog/building-the-site--the-blog"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Building the Site: The Blog")
    end

    it "returns http not_found for invalid urls" do
      get "/blog/foobar"
      expect(response).to have_http_status(:not_found)

      get "/blog/..\/..\/..\/config\/database.yml"
      expect(response).to have_http_status(:not_found)

      get "/blog/../../../config/database.yml"
      expect(response).to have_http_status(:not_found)
    end
  end
end
