class Team < ActiveRecord::Base
    validates :name, :presence => true 

    belongs_to :user
    has_many :players

    def image
         if self.formation == 433
            "https://qph.fs.quoracdn.net/main-qimg-27a531a77968d1381ab0e1684e0ae406"
         else
            "https://qph.fs.quoracdn.net/main-qimg-31476fed6a9d00aedeb080c6ff271864"
         end 
    end
end
