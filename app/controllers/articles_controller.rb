class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  
  def index
    @articles = Article.ordered_by('word_count')
    # @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create

    @article = Article.new(params[:article])
    # @article = Article.new(:title => params[:article][:title], 
    #                        :body => params[:article][:body],
    #                        :tag_list => params[:article][:tag_list], 
    #                        :image => params[:article][:image])
    puts "*" * 50
    puts @article
    warn "Article before save: "
    warn @article.inspect
    @article.save
    puts params[:word_count]
    puts "@" * 50
    puts "params:   " + params.to_s
    # warn "Article after save: "
    # warn @article.inspect
    # raise "Article after save: "
     # raise @article    #"exception class/object expected" noted on page
     #compare @article.inspect shows content of article object
     
    redirect_to article_path(@article)
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
    @article.update_attributes(params[:article])

    flash[:message] = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end
end
