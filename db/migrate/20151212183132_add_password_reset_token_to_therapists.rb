class AddPasswordResetTokenToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :password_reset_token, :string
  end
end
