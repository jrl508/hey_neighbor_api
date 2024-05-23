class SessionsController < ApplicationController
    # Skip authorization for login and logout actions
    skip_before_action :authorized, only: [:create, :destroy]
  
    # POST /login
    def create
      @user = User.find_by(email: session_params[:email])
      
      if @user && @user.authenticate(session_params[:password])
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    # DELETE /logout
    def destroy
      # This is a placeholder action as JWT tokens are stateless and don't need explicit logout handling.
      # Clients can simply discard the token to "log out".
      render json: { message: 'Logged out successfully' }, status: :ok
    end
  
    private
  
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
  