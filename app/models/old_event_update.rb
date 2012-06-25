class OldEventUpdate < ActiveRecord::Base
	establish_connection "old_events"
	belongs_to :old_facebook_event
end
