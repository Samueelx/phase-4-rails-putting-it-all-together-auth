class SessionsController < ApplicationController
    def create
        user = User.find_by!(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: "invalid username or password"}, status: :unauthorized
        end
        rescue ActiveRecord::RecordNotFound
            render json: {errors: ["invalid username"]}, status: :unauthorized
    end

    def destroy
        user = User.find(session[:user_id])
        session.delete :user_id
        head :no_content

        rescue ActiveRecord::RecordNotFound
            render json: {errors: ["you're not logged in"]}, status: :unauthorized
    end

    private
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
