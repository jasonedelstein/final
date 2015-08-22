class User < ActiveRecord::Base

  has_secure_password

  has_many :items, :foreign_key => :borrower_id
  has_many :notes
  has_many :fines
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  
  def fullname
	self.first_name + " " + self.last_name
  end
  
  def fine_total
  
	total = 0.0
	
	if !self.fines.empty?
	  self.fines.each do |fine|
	  total = total + fine.amount
      end
	end
	
	return total
  end
end