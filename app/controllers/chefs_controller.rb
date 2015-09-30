class ChefsController < ApplicationController

before_action :require_same_user[:edit,:update]


    def new
        @chef = Chef.new
    end
    
    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            flash[:success] = "Your account has been created successfully"
            session[:chef_id] = @chef.id
            redirect_to recipes_path
        else
            render 'new'
        end
    end
    
    def edit
        @chef = Chef.find(params[:id])
    end
    
    def update
        @chef = Chef.find(params[:id])
        
        if @chef.update(chef_params)
            flash[:success] = "Your account has been updated successfully"
            redirect_to chef_path(@chef)
        else
            render 'edit'
        end
    end
    
    def index
        @chefs = Chef.paginate(page: params[:page], per_page: 3)
        
    end
    
    def show
        @chef = Chef.find(params[:id])
        @recipes = @chef.recipes.paginate(page: params[:page],per_page: 3)
    end
    private 
    
        def chef_params
            params.require(:chef).permit(:chef_name,:email, :password)
            
        end
        
        def require_same_user
            if current_user !=@chef
                flash[:danger] = "You can'tonly edit your own profile"
                redirect_to root_path
            end
        end
        
        
end