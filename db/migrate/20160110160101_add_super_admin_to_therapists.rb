class AddSuperAdminToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :super_admin, :boolean, :default => false
  end
end
