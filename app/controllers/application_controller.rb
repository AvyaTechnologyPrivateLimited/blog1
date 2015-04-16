class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :username, :avatar, :remember_me)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :first_name, :last_name, :avatar) }
  end

  def get_post
    params[:post_id] ||= params[:id]
    @post = Post.where(:id => params[:post_id]).first
    redirect_to root_path, notice: "Blog not found." if @post.blank?
  end

  def get_all_comments
    @comments = @post.comments.reload
  end


end
