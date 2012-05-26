class FacebookEvent < ActiveRecord::Base

	has_many :event_updates
#	def small_picture
#		self.picture+'?type=small'
#	end
#	def normal_picture
#		self.picture+'?type=normal'
#	end
end
