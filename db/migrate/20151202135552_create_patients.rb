class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :name
      t.string :phone
      t.string :email, null: false
      t.string :zipcode, null: false
      t.string :gender
      t.string :former_religion, null: false
      t.string :description, null: false
      t.integer :distance, null: false

      t.timestamps null: false
    end
  end
end
