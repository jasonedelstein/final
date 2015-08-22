class Accessory < ActiveRecord::Base

# an accessory is a generic, unbarcoded object that can be attached to a given item. Some laptops have cases, some cameras have lens kits, but not all cases are barcoded. One item has one accessory kit.

  has_many :items, :through => :kits
  
  validates :name, presence: true, uniqueness: true
  
end