class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :tag
      t.belongs_to :sender
      t.belongs_to :user
      t.text :contents

      t.timestamps
    end
    add_index :messages, :tag_id
    add_index :messages, :sender_id
    add_index :messages, :user_id
  end
end
