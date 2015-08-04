class Note < ActiveRecord::Base

  belongs_to :item
  belongs_to :user, :foreign_key => :creator_id
  
  validates :text, :creator_id, :created_on, :item_id, presence: true

end