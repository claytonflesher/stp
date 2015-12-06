class AddLatitudeAndLongitudeToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :latitude, :float
    add_column :patients, :longitude, :float
  end
end
