class CreateOldFacebookEvents < ActiveRecord::Migration
  
  def self.up
    if Rails.env.old_events?
	    create_table :old_facebook_events do |t|
	      t.integer   :page_id
	      t.string    :name
	      t.datetime  :start_time
	      t.datetime  :end_time
	      t.string    :location
	      t.text      :description
	      t.datetime  :updated_time
	      t.string    :identifier
	      t.string    :picture
	      t.string    :small_picture
	      t.string    :normal_picture
	      t.string	  :event_url    
	      t.timestamps
		end
	end
  end

  def self.down
    drop_table :old_facebook_events
  end
end
