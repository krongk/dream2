class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :user_id
      t.text :message
      t.string :is_processed

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
