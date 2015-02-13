class Item < ActiveRecord::Base
  validate :name, :presence => true, :length => { :maximum => 255 }
  validate :price, :presence => true, :numericality => { :greater_than => 0 }
end
