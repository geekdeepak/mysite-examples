class CreatePages < ActiveRecord::Migration
  def self.up
    return if Rails.env.old_events?
    create_table :pages do |t|
      t.string :page_identifier
      t.string :name
      t.string :link
      t.string :category
      t.integer :likes
      t.string :website
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :picture
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
