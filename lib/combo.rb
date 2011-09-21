module Combo
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def selections
      selections_result = {}

      self.all.each do | entry | 
        selections_result[entry.name] = entry.id
      end

      selections_result
    end
  end
end