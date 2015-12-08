class AddVerificationTokenToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :verification_token, :string
  end
end
