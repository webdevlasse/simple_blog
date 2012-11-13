class SessionsController < ApplicationController

  def create
     @user = User.find_or_create_by_auth(request.env["omniauth.auth"])
     sign_in @user   #session[:user_id] = @user.id
     redirect_to articles_path, :notice => "Logged in as #{@user.name}"
   end

end
