class HomeController < ApplicationController

  def index
    @users = if current_user.blank?
      User.page params[:page]
    else 
      User.where("id != ?", current_user.id).page params[:page]
    end
  end

end
