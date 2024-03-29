class HomesController < ApplicationController
  STORY_PER_PAGE = 9
  skip_filter :authenticate_user!, :only => [:show,:wait_for_confirmation]
  
  def show
    if current_user && current_user.has_role?(:writer)
      redirect_to writer_dashboard_url
    elsif current_user && current_user.has_role?(:editor)
      redirect_to editor_dashboard_url
    end
    
    
    get_instance_variables
    
    
  end
  
  def writer_dashboard
    extract_filter
    @items = paginate_items(  current_user.stories.
                              find_according_to_post_status( @filter.to_sym ),
                              params[:page],
                              STORY_PER_PAGE)
  end
  
  def editor_dashboard
    extract_filter
    @items = paginate_items(  Story.find_according_to_post_status( @filter.to_sym),
                              params[:page] , 
                              STORY_PER_PAGE)
                              
  end
  
  def extract_filter
    if current_user.has_role? :writer
      @filter =  params[:filter] || "all"
    elsif current_user.has_role? :editor
      @filter =  params[:filter] || "published"
    end
  end
  
  def wait_for_confirmation
  end
  
  
  def get_instance_variables

      
    @main_story = FeaturedStatus.find(:last, :conditions => {
      :position => 0 , :order => 1 
    })
    
    if @main_story.nil?
      @main_story = FeaturedStatus.find(:last, :conditions => {:position => 0})
    end
    
    if not @main_story.nil?
      @main_story = @main_story.story
    end
    
    
    if @main_story.nil?
      @main_story = Story.find(:first, 
        :conditions => {:post_status => POST_STATUS_CONSTANT[:approved] })
    end
    

    
    @top_stories = FeaturedStatus.find(:all, 
            :conditions => {:position => 1}).sort_by { |x| x.order }.map {|x| x.story }
    
    if @top_stories.length == 0 
      @top_stories = Story.find(:all, :conditions => {
        :category_id => 2 ,
        :post_status => POST_STATUS_CONSTANT[:approved]
        }, :limit => 6, :order => "created_at DESC")
    end
    
    
  end
end


