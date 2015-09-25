class Chef < ActiveRecord::Base
    
    has_many :recipes
    before_save {self.email = self.email.downcase}
    validates :chef_name, presence: true, length: {minimum: 3, maximum:40}
    VALID_EMAIL_REGX =  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, length:{maximum:105},
    uniqueness:{case_sensitive: false},
    format: {with: VALID_EMAIL_REGX}
    
    
end
