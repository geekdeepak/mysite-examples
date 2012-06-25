class CreateOldEventUpdates < ActiveRecord::Migration
  def self.up
  	if Rails.env.old_events?
	    create_table :old_event_updates do |t|
	      t.integer :old_facebook_event_id
	      t.integer :attending
	      t.integer :maybe
	      t.integer :invited
	      t.timestamps
	    end
	end
  end

  def self.down
    drop_table :old_event_updates
  end
end
