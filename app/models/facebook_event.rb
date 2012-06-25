class FacebookEvent < ActiveRecord::Base

	belongs_to :page
	has_many :event_updates,:dependent => :destroy

	def self.search(search)
	  find(:first, :conditions => ['identifier = ?', search])
	end
#	def small_picture
#		self.picture+'?type=small'
#	end
#	def normal_picture
#		self.picture+'?type=normal'
#	end
end
