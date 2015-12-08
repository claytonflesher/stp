class AddVerifiedAtToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :verified_at, :datetime
  end
end
