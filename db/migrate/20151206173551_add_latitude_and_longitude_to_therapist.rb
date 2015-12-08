class AddLatitudeAndLongitudeToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :latitude, :float
    add_column :therapists, :longitude, :float
  end
end
