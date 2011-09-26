class SlideshowImage < ActiveRecord::Base
  belongs_to :story
  
  def self.create_and_extract_transloadit(params , story )
    slideshow_image = self.new( params[:slideshow_image] )
    slideshow_image.story_id = story.id
    slideshow_image.save
    slideshow_image.assign_transloadit( params )
    slideshow_image
  end
  
  
  def assign_transloadit(params)
    transloadit = ActiveSupport::JSON.decode(params[:transloadit])#.symbolize_keys[:uploads]
    transloadit_results = ActiveSupport::JSON.decode(params[:transloadit]).symbolize_keys[:results]
    self.image_url = get_url_from_transloadit( transloadit_results,TRANSLOADIT["slideshow"]["return_value"].first )
    self.save
    
    # for type in TRANSLOADIT["story"]["return_value"]
    #   self.story_images.create( :image_type => type , 
    #   :url => get_url_from_transloadit( transloadit_results, type ) )
    # end
  end
  
  def get_url_from_transloadit( transloadit_results, type)
    puts "The result class is #{transloadit_results.class}\n"*3
    puts "The result is #{transloadit_results}\n"*10
    a = transloadit_results[type]  
    puts "This is a #{a}\n"*10
    a.first["url"]
  end
  
  
end
