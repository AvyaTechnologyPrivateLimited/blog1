class PostsController < ApplicationController
  
  before_action :authenticate_user!, except: [:show]
  before_action :get_post, except: [:index, :new, :create, :destroy, :edit, :update]
  before_action :get_all_comments, only: [:show]  
  before_action :post_like, only: [:like_unlike, :like_unlike_on_comment]
  before_action :check_post, only: [:edit, :destroy, :update]
  # GET /blogs
  def index
    @posts = current_user.posts.order("updated_at DESC").page params[:page]
  end

  # GET /blogs/1
  def show
    @comment = Comment.new
  end

  # GET /blogs/new
  def new
    @post = Post.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /blogs/1
  def update
    if @post.update_attributes(post_params)
      redirect_to edit_post_path(@post), notice: 'Post was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  # DELETE /blogs/1
  def destroy
    flash[:notice] = "Post deleted successfully." if post && post.destroy
    redirect_to posts_path 
  end

  def publish
    flash[:notice] = if @post.update_attributes(:publish_at => Time.now, :is_published => true)
      "Post was publish successfully."   
    else
      "Post not published successfully."   
    end  
    redirect_to posts_path
  end

  def like_unlike
    redirect_to "/users/#{@post.user.id}/profile"
  end

  def like_unlike_on_comment
    redirect_to post_path(@post.id)
  end

  private

  def post_like
    unless @post.user == current_user
      fist = @post.fist_bumps.first_or_create(user_id: current_user.id) 
      fist.update_attribute(:is_like, !fist.is_like)
      flash[:notice] = fist.is_like? ? "Thanks for like." : "You have unlike."
    else
      flash[:notice] = "You did not like successfully."
    end
  end

  def post_params
    params.require(:post).permit(:title, :contents)
  end

  def check_post
    @post = current_user.posts.where(id: params[:id]).first
    if @post.blank?
      flash[:alert] = "Requested Post does not exists OR you don't have authorization to access this!"
      redirect_to root_path
    end
  end

end
