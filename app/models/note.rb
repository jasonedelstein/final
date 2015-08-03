class Note < ActiveRecord::Base

  belongs_to :item
  belongs_to :user, :foreign_key => :creator_id

end