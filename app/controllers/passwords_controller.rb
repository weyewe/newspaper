class PasswordsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to edit_password_url , :notice => "Password updated!"
    else
      render :edit
    end
  end
end