class AddPasswordResetTokenToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :password_reset_token, :string
  end
end
