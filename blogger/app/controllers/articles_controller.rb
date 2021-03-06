class ArticlesController < ApplicationController
  include ArticlesHelper

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save!

    redirect_to article_url(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    Article.find(params[:id]).destroy
    
    redirect_to articles_url
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    redirect_to article_url(@article)
  end

end
