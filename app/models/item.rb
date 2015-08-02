class Item < ActiveRecord::Base

  has_many :notes
  belongs_to :category
  belongs_to :type
  belongs_to :user, :foreign_key => :borrower_id
  
  validates :barcode, presence: true, uniqueness: true
  validates :name, :category_id, :type_id, presence: true

end