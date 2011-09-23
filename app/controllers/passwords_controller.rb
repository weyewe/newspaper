class PasswordsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def edit
    @user = current_user
    @profile = current_user.profile
  end

  def update
    @user = current_user

    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to special_edit_password_url  , :notice => "Password updated!"
    else
      redirect_to special_edit_password_url, :notice => "Fail. Try again"
    end
  end
end