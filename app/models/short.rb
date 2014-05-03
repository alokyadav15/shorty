class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value)    
  end

  # a URL may be technically well-formed but may 
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
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
validates :full, length: { maximum: 250 }
validates :full, :presence => true, :url => true 
private 



def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
end 



def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
end 
def setup_slug
		# raise
		self.slug = SecureRandom.hex(5) unless self.slug.present?
end

def setup_short
	self.short =  "#{self.short}/#{self.slug}"
end


end
