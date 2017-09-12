class User < ApplicationRecord
	has_many :watched_movies
	has_many :movies, through: :watched_movies

	has_secure_password

	validates :username, :email, uniqueness: true
	
end
