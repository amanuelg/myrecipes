class StylesController < ApplicationController
    
    def index
        @styles = Style.all
    end
    
    def new 
        @style = Style.new()
    end
    
    def show
        @style = Style.find(params[:id])
    end
    
    def create
        @style = Style.new(style_params)
        
        if @style.save
            flash[:success] = "Style Created Successfully!"
            redirect_to style_path(@style)
        else
            flash[:danger] = "Style not created"
            render :new
        end
    end
    
    def edit
        @style = Style.find(params[:id])
    end
    
    def update
        @style = Style.find(params[:id])
        
        if @style.update_attributes(style_params)
            flash[:success] = "Style updated successfully!"
            redirect_to style_path(@style)
        else
            flash[:danger] = "Style not updated"
            render :edit
        end
    end
    
    
    private
    
    def style_params
        params.require(:style).permit(:name)
    end
    
    
    
    
end