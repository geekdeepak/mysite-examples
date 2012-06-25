class AddEventLinkToFacebookEvent < ActiveRecord::Migration
  def self.up
    return if Rails.env.old_events?
    add_column :facebook_events, :event_url, :string
  end

  def self.down
  end
end
