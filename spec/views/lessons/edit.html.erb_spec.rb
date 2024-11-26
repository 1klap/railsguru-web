require 'rails_helper'

RSpec.describe "lessons/edit", type: :view do
  let(:lesson) {
    Lesson.create!(
      title: "MyString",
      slug: "MyText",
      summary: "MyText",
      content_text: "MyText",
      content_html: "MyText",
      user: nil,
      published: false
    )
  }

  before(:each) do
    assign(:lesson, lesson)
  end

  it "renders the edit lesson form" do
    render

    assert_select "form[action=?][method=?]", lesson_path(lesson), "post" do
      assert_select "input[name=?]", "lesson[title]"
      assert_select "textarea[name=?]", "lesson[slug]"
      assert_select "textarea[name=?]", "lesson[summary]"
      assert_select "textarea[name=?]", "lesson[content_text]"
      assert_select "input[name=?]", "lesson[published]"
    end
  end
end
