
class User < ActiveRecord::Base
has_many :keys

validates_presence_of :email , :on => :create
validates :email, presence: true 
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
validates_uniqueness_of :current_token
# raise
before_create :create_api_token

validates :email, length: { maximum: 25 }


private 
def create_api_token
	self.current_token = create_token
	self.token_counts =+ 1 # unless self.token_counts < 5
end


def create_token
	SecureRandom.hex
end

end
