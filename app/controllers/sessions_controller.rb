class SessionsController < ApplicationController
    def index
      render json: { articles: all_articles }
    end

    def show
      session[:page_views] ||= 0
      session[:page_views] += 1

      if session[:page_views] < 3
        render json: { article: find_article(params[:id]) }
      elsif session[:page_views] == 3
        render json: { article: find_article(params[:id]) }
      else
        render json: { error: "You have exceeded the maximum number of page views.", status: 401 }
      end
    end

    private

    def find_article(id)
      articles = Article.all
      articles.find { |article| article[:id] == id.to_i }
    end

end
