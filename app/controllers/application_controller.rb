class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  include SessionsHelper

  def current_user
  	@current_user = User.find(1)
  end

end

