class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.belongs_to :patient_therapist_relationship, index: true, null: false
      t.timestamps null: false
    end
  end
end
