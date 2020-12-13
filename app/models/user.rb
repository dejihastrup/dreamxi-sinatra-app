class User < ActiveRecord::Base
    validates :username, :presence => true, 
    :uniqueness => true
    validates :password, :presence => true

    has_secure_password
    has_many :teams

    def slug
        username.downcase.gsub(" ", "-")
    end
end