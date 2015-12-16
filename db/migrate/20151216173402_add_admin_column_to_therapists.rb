class AddAdminColumnToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :admin, :boolean, default: false
  end
end
