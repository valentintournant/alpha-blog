class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, execpt: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    # render plain: params[:article](debug)
    @article = Article.new(article_params)
    @article.user = current_user
    # render plain: @article.inspect
    if @article.save
      redirect_to (@article), notice: 'Article was created successfully.'
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to (@article), notice: 'Article was updated successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was destroyed successfully.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
   end
end
