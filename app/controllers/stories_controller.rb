class StoriesController < ApplicationController
  layout "admin"
  skip_filter :authenticate_user!, :only => [:show, :show_public]
  
  
  def new
    @story = Story.new
    @story_image  = @story.story_images.new
    # For transloadit
    # @transloadit_params = {
    #   "auth" => { "key" => TRANSLOADIT[:auth_key] },
    #   "template_id" => TRANSLOADIT[:experiment],
    #   "redirect_url" => stories_url
    # }
  end
  
  def create
    @story = Story.create_and_extract_transloadit(params, current_user)
    
    redirect_to story_url(@story)
  end
  
  def show
    @story = Story.find params[:id] 
  end
  
  def show_public
    @story = Story.find params[:id] 
    render :layout => 'application'
  end
  
  def edit
    @story = Story.find params[:id] 
  end
  
  def update
    @story = Story.find params[:id]
    @story.update_attributes( params[:story] )
    @story.save
    redirect_to story_url(@story)
  end
end
