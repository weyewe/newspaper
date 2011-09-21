require 'combo'
class Category < ActiveRecord::Base
  include Combo
  has_many :stories
end
