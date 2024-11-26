require 'rails_helper'

RSpec.describe "lessons/new", type: :view do
  before(:each) do
    assign(:lesson, Lesson.new(
      title: "MyString",
      slug: "MyText",
      summary: "MyText",
      content_text: "MyText",
      content_html: "MyText",
      user: nil,
      published: false
    ))
  end

  it "renders new lesson form" do
    render

    assert_select "form[action=?][method=?]", lessons_path, "post" do
      assert_select "input[name=?]", "lesson[title]"
      assert_select "textarea[name=?]", "lesson[slug]"
      assert_select "textarea[name=?]", "lesson[summary]"
      assert_select "textarea[name=?]", "lesson[content_text]"
      assert_select "input[name=?]", "lesson[published]"
    end
  end
end
