class User < ActiveRecord::Base
    has_secure_password

    def slug
        username.downcase.gsub(" ", "-")
    end
end