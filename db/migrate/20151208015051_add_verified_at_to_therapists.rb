class AddVerifiedAtToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :verified_at, :datetime
  end
end
