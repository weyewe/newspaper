class AdvertisementsController < ApplicationController
  layout 'admin'
  def create
    @category = Category.find_by_id( params[:category_id])
  end
  
  def update 
  end
  
  def index
    @category  = Category.find( params[:category_id])
    @position_options = (1..MAX_ADS_PER_CATEGORY).collect { |x|  [x, x]}
  end
  
end
