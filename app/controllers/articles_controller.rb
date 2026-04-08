class ArticlesController < ApplicationController
    include ArticlesHelper
    before_action :authenticate_user!, except: [:index, :show]
    before_action :check_ownership, only: [:edit, :update, :destroy]


    def index

        @articles = Article.all
    end    

    def new 
        @article = Article.new
    end    

    def show
        @article = Article.find(params[:id])

        @comment = Comment.new
        @comment.article_id = @article.id
    end
    
    def create 
        @article = Article.new(article_params)
        @article.user_id = current_user.id if user_signed_in?
        if @article.save
            redirect_to article_path(@article)
        else
            render :new
        end
    end 
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end    

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash.notice = "Article '#{@article.title}' Updated!"
            redirect_to article_path(@article)
        else
            render :edit
        end
    end

    private

    def check_ownership
        @article = Article.find(params[:id])
        unless @article.user == current_user
            flash[:alert] = "You are not authorized to perform this action."
            redirect_to articles_path
        end
    end

    def article_params
        params.require(:article).permit(:title, :body)
    end
end
