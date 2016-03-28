class Messages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :conversation, index: true, null: false
      t.string :topic,         null: false
      t.string :body,          null: false
      t.string :sender_type,   null: false
      t.integer :sender_id,    null: false
      t.string :receiver_type, null: false
      t.integer :receiver_id,  null: false
      t.boolean :opened, default: false
      t.datetime :opened_at
      t.timestamps             null: false
    end
  end
end
