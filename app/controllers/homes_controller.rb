class HomesController < ApplicationController
  STORY_PER_PAGE = 9
  skip_filter :authenticate_user!, :only => [:show,:wait_for_confirmation]
  
  def show
    if current_user && current_user.has_role?(:writer)
      redirect_to writer_dashboard_url
    elsif current_user && current_user.has_role?(:editor)
      redirect_to editor_dashboard_url
    end
    
    @items = Story.order("created_at").page( params[:page] ).per(STORY_PER_PAGE)
    # @items = Story.where(:post_status => 2).order("created_at").page( params[:page] ).per(STORY_PER_PAGE)
    @main_story = Story.find(:first, :conditions => {:category_id => 1})
    if @main_story == nil 
      @main_story = Story.first
    end
    @top_stories = Story.find(:all, :conditions => {
      :category_id => 2 ,
    }, :limit => 6)
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
  
end


