require 'uri'
class Short < ActiveRecord::Base

def to_param
	"#{slug}"
end


before_save :process_url
before_create :setup_slug
before_create :setup_short

validates_uniqueness_of :slug
validates_presence_of :full , :message =>  "Please Provide  a valid  URL"
validates :slug, length: { maximum: 6 }
validates :full, length: { maximum: 100 }

private 
def process_url
	valid_url?(self.full.gsub(/\s+/, ""))
end

def setup_slug
		# raise
		self.slug = SecureRandom.hex(5) unless self.slug.present?
end

def setup_short
	self.short =  "#{self.short}/#{self.slug}"
end

def valid_url?(uri)
  !!URI.parse(uri)
rescue URI::InvalidURIError
  false
end

end
