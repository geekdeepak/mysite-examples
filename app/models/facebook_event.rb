class FacebookEvent < ActiveRecord::Base

	belongs_to :page
	has_many :event_updates
#	def small_picture
#		self.picture+'?type=small'
#	end
#	def normal_picture
#		self.picture+'?type=normal'
#	end
end
