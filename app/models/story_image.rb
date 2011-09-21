class StoryImage < ActiveRecord::Base
  belongs_to :story
  
  def destroy_other_than_original
    if self.image_type != ":original"
      self.destroy
    end
  end
end
