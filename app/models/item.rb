class Item < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :price, :presence => true, :numericality => { :greater_than => 0 }
end
