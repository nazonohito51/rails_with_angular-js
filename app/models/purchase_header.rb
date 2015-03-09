class PurchaseHeader < ActiveRecord::Base
  has_many :purchase_details
end
