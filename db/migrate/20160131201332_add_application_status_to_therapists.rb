class AddApplicationStatusToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :application_status, :string, default: "pending"
  end
end
