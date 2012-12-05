class CommentsController < ApplicationController
  before_filter :authorize_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.article, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @comment.article }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.article }
    end
  end

  private
    def authorize_user!
      if ["destroy", "update"].include?(params[:action])
        unless can? params[:action], Comment
          redirect_to articles_path, notice: "NO! You are not authorized!!!"
        end
      end
    end

end
