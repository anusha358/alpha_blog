class User < ActiveRecord::Base
  validates :username, presence:true ,
                       length: {minimum:8,maximum:15},
                       uniqueness: { case_sensitive: false }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence:true,
                      length:{minimum:10,maximum: 30},
                      uniqueness: { case_sensitive: false },
                      format: {with: VALID_EMAIL_REGEX}
  
end