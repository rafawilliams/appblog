class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    
    # Optionally set the author_name to the current user's email for accountability
    @comment.author_name = current_user.email if @comment.author_name.blank?
  
    if @comment.save
      redirect_to article_path(@comment.article)
    else
      @article = @comment.article
      render 'articles/show'
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
