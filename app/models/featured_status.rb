class FeaturedStatus < ActiveRecord::Base
  belongs_to :story


  def adjust_order_and_update( params )
    FeaturedStatus.adjust_order(params[:featured_status] )
    self.update_time = Time.now
    self.position = params[:featured_status][:position].to_i
    self.order = params[:featured_status][:order].to_i
    self.save
  end
  
  def FeaturedStatus.adjust_order( featured_status )
    others = FeaturedStatus.find(:all, :conditions => {
        :order => featured_status[:order].to_i,
        :position => featured_status[:position].to_i
    })
    
    others.each do |o|
      o.order = nil
      o.position = nil
      o.save
    end

  end
end
