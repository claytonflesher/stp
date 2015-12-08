class AddVerificationTokenToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :verification_token, :string
  end
end
