class SlideshowImagesController < ApplicationController
  layout 'admin'
  
  def new
    @story = Story.find( params[:story_id])
    @slideshow_image = SlideshowImage.new 
  end
  
  def create
    @story  = Story.find( params[:story_id] )
    SlideshowImage.create_and_extract_transloadit( params, @story )
    redirect_to new_story_slideshow_image_url(@story )
  end
  
  def assign_transloadit( params )

    # transloadit = JSON.parse params[:transloadit]
    transloadit = ActiveSupport::JSON.decode(params[:transloadit])#.symbolize_keys[:uploads]
    transloadit_results = ActiveSupport::JSON.decode(params[:transloadit]).symbolize_keys[:results]

    for type in TRANSLOADIT["story"]["return_value"]
      self.story_images.create( :image_type => type , 
      :url => get_url_from_transloadit( transloadit_results, type ) )
    end
  end
   
   
end
