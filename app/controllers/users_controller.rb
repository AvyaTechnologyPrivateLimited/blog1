class UsersController < ApplicationController
  
  def search_user
    if params[:search_keyword].present?
      users = User.user_serach_by_keyword(params[:search_keyword])
      return @users = users.uniq{|x| x.id}
    end
  end

  def profile
    @user = User.where(:id => params[:id].to_i).first
    redirect_to root_path, notice: 'user not found.' if @user.blank? 
    @published_posts = @user.posts.published_posts
  end

end
