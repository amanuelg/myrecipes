class IngredientsController < ApplicationController

    def index
    end
    
    def new
        @ingredient = Ingredient.new()
    end
    
    def show
        @ingredient = Ingredient.find(params[:id])
    end
    
    def create 
        @ingredient = Ingredient.new(ingredient_params)
        
        if @ingredient.save
            flash[:success] = "Created Successfully"
            redirect_to ingredient_path(@ingredient)
        else
            flash[:danger] = "Not created"
            render :new
        end
    end
    
    def edit
        @ingredient = Ingredient.find(params[:id])
    end
    
    def update
        @ingredient = Ingredient.find(params[:id])
        
        if @ingredient.update_attributes(ingredient_params)
            flash[:success] = "Ingredient updated successfully"
            redirect_to ingredient_path(@ingredient)
        else
            flash[:danger] = "Ingredient not created"
            render :edit
        end
    end
    
    
    private
    
    def ingredient_params
        params.require(:ingredient).permit(:name)
    end
            
end