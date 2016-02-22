class ArticlesController < ApplicationController
  
  before_action:find_article,only:[:edit,:show,:update,:destroy]
   before_action:require_user,except:[:index,:show]
    before_action:require_same_user,only:[:edit,:update,:destroy]
  
  def index
    @articles=Article.paginate(:page => params[:page],:per_page => 7)
  end
  
  def new
    @article =Article.new
    
  end
  def edit
  end
  def create 
    #render plain: params[:article].inspect
   
    @article = Article.new(article_params)
    @article.user = current_user
    
    if @article.save
      flash[:success] = "article was sucessfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    
    end
  end
  
  def show
  end
  
  def update
  
    if @article.update(article_params)
      flash[:success] = "article was sucessfully updated"
       redirect_to article_path(@article)
    else
      render 'edit'
      
    end
  end
  
  def destroy
  
  @article.destroy
  flash[:danger] = "article was deleted sucessfully"
  redirect_to articles_path
  
  
  end
  
  private
  
  def find_article
      @article = Article.find( params[:id])
    
  end
  
  
  def article_params
    params.require(:article).permit(:title,:description)
    
  end
  def require_same_user
    if ( current_user != @article.user && !current_user.admin?)
      flash[:danger] = "you are restricted to do this operation"
      redirect_to root_path
    end
    
  end
end
