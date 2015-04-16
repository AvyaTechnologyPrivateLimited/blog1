class CommentsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_post

  # GET /comments/new

  def new
    @comment = @post.comments.new
  end

  # GET /comments/1/edit
  def edit
    @comment = @post.comments.where(:id => params[:id]).first
  end

  # POST /comments
  def create
    @comment = @post.comments.new(comment_params.merge(:user_id => current_user.id))
    @comment.save
    get_all_comments
  end

  # PUT /comments/1
  def update
    @comment = @post.comments.where(:id => params[:id]).first
    if @comment.update_attributes(comment_params)
      @message = 'Comment was successfully updated.'
      render :template => "/comments/edit"
    else
      render :template => "/comments/edit"
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = @post.comments.where(:id => params[:id]).first
    @comment.destroy
    get_all_comments
    render :template => "/comments/create"
  end

  private

  def comment_params
    params.require(:comment).permit(:contents)
  end
end
