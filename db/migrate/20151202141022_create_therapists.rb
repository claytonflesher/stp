class CreateTherapists < ActiveRecord::Migration
  def change
    create_table :therapists do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :zipcode, null: false
      t.string :practice, null: false
      t.integer :years_experience, null: false
      t.string :qualifications, null: false
      t.string :website
      t.string :gender, null: false
      t.string :religion, null: false
      t.string :former_religion
      t.string :licenses, null: false
      t.string :main_license, null: false
      t.boolean :distance_counseling, null: false
      t.string :langauges
      t.string :purpose, null: false
      t.string :description
      t.string :approach

      t.timestamps null: false
    end
  end
end
