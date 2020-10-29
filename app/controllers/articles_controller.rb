class ArticlesController < ApplicationController

  def show
    # byebug
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article](debug)
    @article = Article.new(article_params)
    # render plain: @article.inspect
    if @article.save
      redirect_to (@article), notice: 'Article was created successfully.'
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
