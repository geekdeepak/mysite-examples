class CreateEventUpdates < ActiveRecord::Migration
  def self.up
    return if Rails.env.old_events?
    create_table :event_updates do |t|
      t.integer :facebook_event_id
      t.integer :attending
      t.integer :maybe
      t.integer :invited
      t.timestamps
    end
  end

  def self.down
    drop_table :event_updates
  end
end
