class HomeController < ApplicationController
  before_action :set_current_user
  def index
    def set_current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
