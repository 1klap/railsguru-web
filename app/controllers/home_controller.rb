class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    @lessons = Lesson.published
  end
end
