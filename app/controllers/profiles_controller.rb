class ProfilesController < ApplicationController
  layout 'admin'
  
  before_filter :define_tab_filter
  def new 
    @profile = current_user.profile ||  Profile.new
  end
  
  def edit
    @profile = current_user.profile
  end
  
  def show
    @profile = current_user.profile
  end
  
  def create
    @profile = Profile.create_and_extract_transloadit(params, current_user)
    
    redirect_to cropper_url
  end
  
  def update
    @profile = Profile.find(params[:id])
    @profile.update_attributes( params[:profile] )
    if params[:transloadit] 
      @profile.update_and_extract_transloadit( params )
    end
    
    redirect_to cropper_url
  end
  
  def show_cropper
    @profile = current_user.profile
  end
  
  def crop
    current_user.profile.execute_cropping( params[:profile] )
    redirect_to profile_url(current_user.profile )
  end
  
  def show_public
    @profile = Profile.find params[:id] 
  end
  
  def edit_credential
    @user = current_user
    @profile= current_user.profile
  end
  
  def update_credential
    if current_user.update_attributes( params[:user])
      flash[:notice] = "Successfully changed the password"
    else
      flash[:notice] = "Fail to change the password"
    end
    redirect_to edit_credential_url 
  end
  protected
  def define_tab_filter
    if params[:action] == "show" 
      @filter = "profile_view"
    elsif params[:action] == "edit"
      @filter = "edit_profile"
    else
      @filter = "credential"
    end
  end
end
