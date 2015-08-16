class User < ActiveRecord::Base

  has_secure_password

  has_many :items, :foreign_key => :borrower_id
  has_many :notes
  
  validates :email, presence: true, uniqueness: true
  
  def fullname
	self.first_name + " " + self.last_name
  end

end