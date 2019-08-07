class SessionsController < ApplicationController
    before_action :require_logged_in, only: [:show]
    before_action :require_logged_out, only: [:create, :new]

    def new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        
        if @user 
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ["Invalid Credentials"]
            render :new
        end
    end 

    def destroy
        logout
        redirect_to new_session_url
    end
end
