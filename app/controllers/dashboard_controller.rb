class DashboardController < ApplicationController
  layout "admin"
  STORY_PER_PAGE = 9
  def writer
    ensure_user_is( :writer )
    extract_filter
    # @items = Story.order("created_at").page( params[:page] ).per(STORY_PER_PAGE)
    @items = paginate_items(  current_user.stories.
                                find_according_to_post_status( @filter.to_sym ),
                                params[:page],
                                STORY_PER_PAGE)

  end
  
  def editor
    ensure_user_is( :editor )
    
    
    extract_filter
    # @items = Story.order("created_at").page( params[:page] ).per(STORY_PER_PAGE)
    # @items = Story.where(:post_status => 2).order("created_at").page( params[:page] ).per(STORY_PER_PAGE)
    @items = paginate_items(  Story.find_according_to_post_status( @filter.to_sym),
                              params[:page] , 
                              STORY_PER_PAGE)
  end
  
  def ensure_user_is( role )
    if not current_user.has_role? role
      redirect_to root_url
      return
    end
  end
  
  def extract_filter
    if current_user.has_role? :writer
      @filter =  params[:filter] || "all"
    elsif current_user.has_role? :editor
      @filter =  params[:filter] || "published"
    end
  end
  
  
end
