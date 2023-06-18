class ArticlesController < ApplicationController
  def create
    article = Article.new(article_params)
    article.save!

    render json: {
      article: article
    }, status: :ok
  end

  def show
    article = Article.find(params[:id])

    render json: {
      article: article
    }, status: :ok
  end

  def update
    article = Article.find(params[:id])
    article.update!(article_params)

    render json: {
      article: article
    }, status: :ok
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy

    head :ok
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
