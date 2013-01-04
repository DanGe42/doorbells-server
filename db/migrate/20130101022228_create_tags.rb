class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :user
      t.string :location
      t.string :tid

      t.timestamps
    end
    add_index :tags, :user_id
  end
end
