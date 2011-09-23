module ApplicationHelper
  def facebox_login_link_to(*args, &block)
    return link_to(*args, &block) if current_user
    url = url_for(args.second)
    cookies[:return_to] = args.third[:return_to] if args.third && args.third[:return_to]
    options = args.third || {}
    options.merge!({:return_to => url, :rel=>"nofollow"})
    link_to args.first, new_session_path(:return_to => url), options
  end
  
  def get_stylesheets(is_admin=false)
    stylesheets = ['base', 'main', 'facebox']
    stylesheets.concat(['new_style','widget']) if params[:controller]!='homes' && params[:controller]!='pitches' && params[:controller]!='news_items' && params[:controller]!='posts' && params[:controller]!='session' && params[:controller]!='pages' && params[:controller]!='stories'
    stylesheets << 'admin' if is_admin
    stylesheet_link_tag stylesheets, :media => "all"# , :cache => stylesheet_name?(stylesheets)
  end
  
  def stylesheet_name?(stylesheets)
    names = ['global']
    names << 'styles' if stylesheets.detect { |s| s =~ /(?:new_style)/i }
    names << "admin" if stylesheets.detect { |s| s =~ /(?:admin)/i }  
    "cache/#{names.join('_')}"
  end
  
  def transloadit_value_json
    value = {}
    value["auth"] = {
      "key" => "a919ae5378334f20b8db4f7610cdd1a7"
    }
    
    value["template_id"] = "dd15de5ad2b942a2938869f513add756"
    value["redirect_url"] = stories_url
    value["notify_url"] = "http://google.com"
    value.to_json
  end
  
  
  def transloadit_value_profile_json( resource )
    value = {}
    value["auth"] = {
      "key" => "a919ae5378334f20b8db4f7610cdd1a7"
    }
    
    value["template_id"] = "08d058abcdbb4e9eb57522cf83e9d5bf"
    if resource.user == nil 
      value["redirect_url"] = profiles_url
    else
      value["redirect_url"] = profile_url( resource  )
    end
    value["notify_url"] = "http://google.com"
    value.to_json
  end
  
  
  def transloadit_value_profile_method( transloadit_hash , redirect_url )
    value = {}
    value["auth"] = {
      "key" => transloadit_hash("key")
    }
    
    value["template_id"] = transloadit_hash("template_id")
    value["redirect_url"] = redirect_url 
    value.to_json
  end
  
  def give_story_count( story_type )
    counts = current_user.count_story_with_type( story_type )
    
    if counts == 0 
      return ""
    else
      return "(#{counts})"
    end
  end
  
  def give_story_count_editor( story_type )
    counts = Story.count_all_stories_with_type( story_type )
    
    if counts == 0 
      return ""
    else
      return "(#{counts})"
    end
  end
  
  
  def extract_profile_setting_link
    if current_user.profile == nil || current_user.profile.name == nil
      return new_profile_url
    else
      return vanity_url(current_user.profile )
    end 
  end
end
