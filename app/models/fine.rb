class Fine < ActiveRecord::Base

  belongs_to :user
  belongs_to :item
  
  validates :user_id, :item_id, :amount, :created_on, presence: true
  
end