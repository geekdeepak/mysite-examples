class OldFacebookEvent < ActiveRecord::Base
	establish_connection "old_events"
	has_many :old_event_updates,:dependent => :destroy
end
