class User < ActiveRecord::Base

  has_secure_password

  has_many :items
  has_many :notes
  
  def fullname
	self.first_name + " " + self.last_name
  end

end