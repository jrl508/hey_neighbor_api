class UsersController < ApplicationController
  include Rails.application.routes.url_helpers

  before_action :authorized, only: [:show, :index, :update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: { user: @user.as_json(only: [:id, :email, :first_name, :last_name, :phone_number, :location]), token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    render json: { user: @user.as_json(only: [:id, :email, :first_name, :last_name, :phone_number, :location], methods: [:profile_image_url]) }
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      render json: { user: @user.as_json(only: [:id, :email, :first_name, :last_name, :phone_number, :location])}
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_profile_image
    @user = User.find(params[:id])

    if @user.update(profile_image: params[:image])
      render json: { message: 'Image uploaded successfully', image_url: url_for(@user.profile_image) }
    else
      render json: { message: 'Error uploading image' }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  # This method is used to find a user by ID and is only used within this controller.
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  # This method is used to permit specific user parameters and is only used within this controller.
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number, :password, :location)
  end
end
