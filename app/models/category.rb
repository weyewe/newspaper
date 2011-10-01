require 'combo'
class Category < ActiveRecord::Base
  include Combo
  has_many :stories
  has_many :advertisements
  
end
