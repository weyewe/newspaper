class FeaturedStatusesController < ApplicationController
  layout 'admin'
  
  def index
    get_filter 
    
    @items= nil
    
    @items = paginate_items( FeaturedStatus.find(:all, :order => "update_time DESC", 
                              :conditions => { 
                                :is_published => true
                                }),  params[:page], STORY_PER_PAGE)
                            
    # @items = paginate_items(  Story.find(:all, :order => "created_at DESC"),
    #                           params[:page] , 
    #                           STORY_PER_PAGE
    #                           )
    @position_options = POSITION_CONSTANT.collect { |key, value| [value, key ]}
    @ordering_options = (1..MAX_ORDER_LIMIT).collect { |x|  [x, x]}
  end
  
  
  def create
    @story = Story.find(params[:story_id])
    @featured_status = FeaturedStatus.new( params[:featured_status])
    @featured_status.story_id = @story.id
    @featured_status.save
    respond_to do |format|
      format.html { redirect_to story_url(@featured_status.story.id )}
      format.js
    end

  end
  
  def update
    @story = Story.find( params[:story_id])
    @featured_status = @story.featured_status
    
    if  params[:from_layout_editor].nil?
      @featured_status.adjust_order_and_update( params )
    else
      @featured_status.update_attributes(params[:featured_status])
    end
    # @story.featured_status.update_time = Time.now
    #    @story.featured_status.update_attributes( params[:featured_status] )
    
    
    respond_to do |format|
      format.html do 
        if  params[:from_layout_editor].nil?
          redirect_to story_url(@story)  
        else
          redirect_to layout_editor_url
        end
        return
      end
      format.js
    end
  end
  
  protected
  def get_filter
    @filter =  params[:filter] || "latest_stories"
  end
end
