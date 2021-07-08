class User < ApplicationRecord
	before_save { self.email = email.downcase }

	has_many :articles

	validates :username, presence: true, 
											uniqueness: { case_sensitive: false },  
											length: { minimum: 4, maximum: 25 }
	validates :email, presence: true, 
										uniqueness: { case_sensitive: false },
										length: { maximum: 90 },
										format: { with: URI::MailTo::EMAIL_REGEXP }
<<<<<<< HEAD

	has_secure_password										
=======
	has_secure_password
>>>>>>> users-signup
end