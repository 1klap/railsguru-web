require 'rails_helper'

RSpec.xdescribe "lessons/index", type: :view do
  before(:each) do
    assign(:lessons, [
      Lesson.create!(
        title: "Title",
        slug: "MyText",
        summary: "MyText",
        content_text: "MyText",
        content_html: "MyText",
        user: nil,
        published: false
      ),
      Lesson.create!(
        title: "Title",
        slug: "MyText",
        summary: "MyText",
        content_text: "MyText",
        content_html: "MyText",
        user: nil,
        published: false
      )
    ])
  end

  it "renders a list of lessons" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
