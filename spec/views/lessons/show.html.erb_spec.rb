require 'rails_helper'

RSpec.describe "lessons/show", type: :view do
  before(:each) do
    assign(:lesson, Lesson.create!(
      title: "Title",
      slug: "MyText",
      summary: "MyText",
      content_text: "MyText",
      content_html: "MyText",
      user: nil,
      published: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
