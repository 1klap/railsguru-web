class LessonsController < ApplicationController
  include Authorization
  allow_unauthenticated_access only: %i[ index show ]

  before_action :set_lesson_by_slug, only: :show
  before_action :set_lesson, only: %i[ edit update destroy ]
  before_action -> { authorize_if Current.user&.admin? }, except: %i[ index show ]
  before_action -> { authorize_if @lesson.published? || Current.user&.admin? }, only: :show

  # GET /lessons or /lessons.json
  def index
    if Current.user&.admin?
      @lessons = Lesson.all
    else
      @lessons = Lesson.published
    end
  end

  # GET /lessons/1 or /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = Current.user

    rougeified = Rougeify.new(filter_html: true, hard_wrap: true)
    markdown_renderer = Redcarpet::Markdown.new(rougeified, autolink: true, fenced_code_blocks: true)
    @lesson.content_html = markdown_renderer.render(@lesson.content_text)
    if @lesson.published? || @lesson.published_at.nil?
      @lesson.published_at = Time.zone.now
    end

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_path(@lesson.slug), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    rougeified = Rougeify.new(filter_html: true, hard_wrap: true)
    markdown_renderer = Redcarpet::Markdown.new(rougeified, autolink: true, fenced_code_blocks: true)
    @lesson.assign_attributes(lesson_params)
    @lesson.content_html = markdown_renderer.render(@lesson.content_text)
    if @lesson.published? || @lesson.published_at.nil?
      @lesson.published_at = Time.zone.now
    end

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_path(@lesson.slug), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy!

    respond_to do |format|
      format.html { redirect_to lessons_path, status: :see_other, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_lesson_by_slug
      @lesson = Lesson.find_by_slug(params.expect(:id))
    end

    def set_lesson
      @lesson = Lesson.find(params.expect(:id))
    end

    def lesson_params
      params.expect(lesson: [ :title, :slug, :summary, :content_text, :content_html, :published, :published_at ])
    end
end

