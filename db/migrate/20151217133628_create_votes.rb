class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id, index: true
      t.integer :votee_id, index: true

      t.timestamps null: false
    end

    add_index :votes, [:voter_id, :votee_id], unique: true
  end
end
