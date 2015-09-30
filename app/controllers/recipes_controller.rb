class RecipesController < ApplicationController

    before_action :set_recipe, only: [:edit,:update,:show,:like]
    before_action :require_login, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update]
    
    
    def index
       # @recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
       @recipes = Recipe.paginate(page: params[:page],per_page: 4)
    end
    
    def show
        
    end
    
    def new
        @recipe = Recipe.new
    end
    
    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = current_user
        
        if @recipe.save
            flash[:success] = "Your recipe was created successfully"
            redirect_to recipes_path
        else
            render 'new'
        end
    end
    
    def edit
        
    end
    
    def update
        
        if @recipe.update(recipe_params)
            flash[:session] = "Your recipe was updated succesfully"
            redirect_to recipe_path(@recipe)
            
        else
            render :edit
        end
    end
    
    def like
        
        
        @like = Like.create(like: params[:like], recipe_id: @recipe.id, chef_id: current_user)
        
        if @like.valid?
            flash[:success] = "Your selection was succesfull"
            redirect_to :back
        else
            flash[:danger] = "You can like/dislike only once"
            redirect_to :back
        end
    end
    
    private 
    
        def recipe_params
            params.require(:recipe).permit(:name, :summary, :description, :picture)
        end
        
        def set_recipe
            @recipe = Recipe.find(params[:id])    
        end
        
        def require_same_user
            if @recipe.chef != current_user
                flash[:danger] = "You can only edit your won recipes"
                redirect_to recipes_path
            end
            
        end
        
end







