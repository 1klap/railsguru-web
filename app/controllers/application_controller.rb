class ApplicationController < ActionController::Base
  include Authentication
  before_action :ensure_visitor_hash_present
  before_action :annotate_request

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  # ======== REQUEST TRACKING ========
  def ensure_visitor_hash_present
    cookies.permanent[:_railsguru_visitor_hash] = SecureRandom.uuid unless cookies[:_railsguru_visitor_hash]
  end

  def annotate_request
    response[:visitor_hash] = cookies.permanent[:_railsguru_visitor_hash]
    response[:user_id] = Current.user.id if authenticated?
  end
end
