class AddStatusToPatientTherapistRelationships < ActiveRecord::Migration
  def change
    add_column :patient_therapist_relationships, :status, :string
  end
end
