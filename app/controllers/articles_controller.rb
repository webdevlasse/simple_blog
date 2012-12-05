class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :authorize_user!

  def index
    @articles = Article.all
  end

  def show
    @article  = Article.includes(:comments).find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
    end
  end

  private
    def authorize_user!
      p "*" * 100
      p params[:action]
      if ["destroy", "update"].include?(params[:action])
        unless can? params[:action], Article
          redirect_to articles_path, notice: "NO! You are not authorized!!!"
        end
      end
    end
end
