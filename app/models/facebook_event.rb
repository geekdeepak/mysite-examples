class FacebookEvent < ActiveRecord::Base

	def small_picture
		self.picture+'?type=small'
	end
	def normal_picture
		self.picture+'?type=normal'
	end
end
