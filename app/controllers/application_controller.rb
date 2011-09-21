class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  
  def after_sign_in_path_for(resource)
    if resource.has_role? :admin
      admin_dashboard_path 
    elsif resource.has_role? :editor
      editor_dashboard_path
    elsif resource.has_role? :writer
      writer_dashboard_url 
    end
  end


  # def after_sign_up_path_for(resource)
  #   "http://www.google.com"
  # end
  # 
  
  def  after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def after_inactive_sign_up_path_for(resource)
        confirmation_waiting_url
  end
  
  
  def paginate_items( items, page, item_per_page )
    Kaminari.paginate_array(items).page(page).per(item_per_page)
  end
  
  
  
end
