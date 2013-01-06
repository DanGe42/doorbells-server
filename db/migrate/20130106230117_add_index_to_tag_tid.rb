class AddIndexToTagTid < ActiveRecord::Migration
  def self.up
    add_index :tags, :tid, :unique => true
  end

  def self.down
    remove_index :tags, :tid
  end
end
