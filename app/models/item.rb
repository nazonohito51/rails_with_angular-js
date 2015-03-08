class Item < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :price, :presence => true, :numericality => { :greater_than => 0 }

  def self.search(on_sale)
    if on_sale
      Item.where(:on_sale => on_sale == "true" ? true : false)
    else
      Item.all
    end
  end
end
