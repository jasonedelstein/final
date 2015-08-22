class Item < ActiveRecord::Base

  enum status: [ :available, :borrowed, :retired ]
  enum condition: [:good, :damaged, :acceptable ]

  has_many :notes
  has_many :accessories, :through => :kits
  belongs_to :category
  belongs_to :type
  belongs_to :user, :foreign_key => :borrower_id
  
  validates :barcode, presence: true, uniqueness: true
  validates :name, :category_id, :type_id, presence: true

end