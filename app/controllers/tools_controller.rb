class ToolsController < ApplicationController
    before_action :set_tool, only: [:show, :update, :destroy]
  
    def index
      @tools = Tool.all
      render json: @tools
    end
  
    def show
      render json: @tool
    end
  
    def create
      @tool = current_user.tools.build(tool_params)
      if @tool.save
        render json: @tool, status: :created
      else
        render json: @tool.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @tool.update(tool_params)
        render json: @tool
      else
        render json: @tool.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @tool.destroy
    end
  
    private
  
    def set_tool
      @tool = Tool.find(params[:id])
    end
  
    def tool_params
      params.require(:tool).permit(:name, :description, :price_per_day)
    end
  end  