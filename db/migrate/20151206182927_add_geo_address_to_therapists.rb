class AddGeoAddressToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :geo_address, :string
  end
end
