class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  	def current_user
    	@current_user = User.find(2)
	end
end
