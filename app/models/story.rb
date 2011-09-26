require 'transloadit'
require 'open-uri'

class Story < ActiveRecord::Base
  # has_friendly_id :title, :use_slug => true
  extend FriendlyId
  friendly_id :title, :use => :slugged
  def should_generate_new_friendly_id?
    new_record?
  end
      
      
  has_many :story_images
  belongs_to :user
  belongs_to :category
  
  # 0 == draft
  # 1 == published  ( in-review by editor )
  # 2 == approved
  # 3 == featured
  
  after_create :send_notification_email
  
  def self.create_and_extract_transloadit( params , current_user)
    story = self.new( params[:story] )
    story.user_id = current_user.id
    story.save
    story.assign_transloadit( params )
    story
  end
  
  def get_url_from_transloadit( transloadit_results, type)
    puts "The result class is #{transloadit_results.class}\n"*3
    puts "The result is #{transloadit_results}\n"*10
    a = transloadit_results[type]  
    puts "This is a #{a}\n"*10
    a.first["url"]
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
  
  def get_image_url_with_type( type )
    a = StoryImage.find( :first, :conditions => {:story_id => self.id, :image_type => type.to_s } )
    a.url
  end
  
  def facebook_friendly_id_slug
    Slug.find(:first, :conditions => {
      :sluggable_id => self.id,
      :sluggable_type => self.class.to_s
    }).name
  end
  
  def self.find_according_to_post_status( filter_sym )
    @stories = nil
    if filter_sym != :all 
      @stories = Story.find(:all, :conditions => {
        :post_status => POST_STATUS_CONSTANT[filter_sym]
      })
    else
      @stories = Story.all
    end
    
    return @stories 
  end
  
  def self.count_all_stories_with_type( story_type )
    self.where(:post_status => POST_STATUS_CONSTANT[story_type] ).count
  end
  
  def get_title_with_length( headline_length) 
    current_headline = self.title
    if( current_headline.length > headline_length)
      current_headline[0..headline_length] + "..."
    else
      current_headline
    end
    
  end
  
  
  
  # The following is only used in development
  
  def self.add_170px
    
  end
  
  def self.refesh_story
    for story in self.all
      story.refresh
    end
  end
  
  
  
  def refresh
    for story_pic in self.story_images
      story_pic.destroy_other_than_original
    end
    
    self.reinitiate_transloadit
  end
  
  def reinitiate_transloadit
    return_values = ["homepage", "story", "teaser"]
    transloadit = Transloadit.new(
    :key    => 'a919ae5378334f20b8db4f7610cdd1a7',
    :secret => '7dff49aab9dc91cb62a0fd34bf9e8c2d6eb3b207'
    )

     

    original_image_url = StoryImage.find(:first, :conditions => {
      :story_id => self.id, :image_type => ":original"
      }).url 

    file = open(   original_image_url      )
    
    response = transloadit.assembly(
    :template_id => '0995901d643f48f59c3aaa0d341cc7c0'
    ).submit!( file )
    
    
    # response = assembly.submit! file

    while not response.completed? do
      sleep 1
      response.reload!
    end

    for return_value in return_values
      if response["results"][return_value] != nil 
        url  = response["results"][return_value].first["url"]
        StoryImage.create( :story_id => self.id, :url => url, :image_type => return_value)
      end
       
    end
  end
  
  
  def send_notification_email
    UserMailer.welcome_email(self.user, self).deliver
  end
end
