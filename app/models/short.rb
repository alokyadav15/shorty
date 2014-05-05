class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL [try with http in front of it]") unless url_valid?(value)    
  end

  # a URL may be technically well-formed but may 
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    url = URI.parse(url.to_s) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
    # raise
  end 
end
require 'uri'
class Short < ActiveRecord::Base

def to_param
	"#{slug}"
end


before_create :setup_slug
before_create :setup_short

validates_uniqueness_of :slug 
validates_presence_of :full , :message =>  "Please Provide  a valid  URL"
validates :slug, length: { maximum: 25 }
validates :slug, length: { minimum: 3 } , allow_blank: true
validates :full, length: { maximum: 250 }
validates :full, length: { minimum: 3 }
validates :full, :presence => true, format: {
  with: /(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?/,
  message: "url not valid" 
}

validates :slug, format: { with: /[A-Za-z0-9.&]*\z/,
    message: "only  letters are allowed" }

before_create :setup_delete_token
before_save :encrypt
before_save :remove_full

def self.decrypt(short)
#  begin
  crypt = ActiveSupport::MessageEncryptor.new(short.key)
  plain_url = crypt.decrypt_and_verify(short.encrypted_url) 
#  end 
end


private 

def remove_full
  self.full = nil
end



def setup_delete_token
  self.delete_token = loop do
      delete_token = SecureRandom.urlsafe_base64(nil, false)
      break delete_token unless self.class.exists?(delete_token: delete_token)
    end
end


def encrypt
    raw_url = self.full
    parsed = URI.parse("#{raw_url}") rescue false
    if parsed.scheme.nil?
      self.full = "http://#{raw_url}"
    end
    salt  = SecureRandom.random_bytes(64)
    self.key = ActiveSupport::KeyGenerator.new('password').generate_key(salt) # => "\x89\xE0\x156\xAC..."
    crypt = ActiveSupport::MessageEncryptor.new(self.key)                       # => #<ActiveSupport::MessageEncryptor ...>
    self.encrypted_url = crypt.encrypt_and_sign(self.full.to_s)              # => "NlFBTTMwOUV5UlA1QlNEN2xkY2d6eThYWWh..."
end


def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
end 



def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
end 
def setup_slug
    if self.slug.present?
      # raise
      self.slug = self.slug.gsub(/[^0-9A-Za-z]/, '')
    else
      # raise
      self.slug = SecureRandom.urlsafe_base64(5) 
    end
end

def setup_short
  # raise
	self.short =  "#{self.short}/#{self.slug}"
end


end
