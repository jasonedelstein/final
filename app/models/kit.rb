class Kit < ActiveRecord::Base

  belongs_to :item
  belongs_to :accessory
  
  validates :item_id, :accessory_id, presence: true
  
end