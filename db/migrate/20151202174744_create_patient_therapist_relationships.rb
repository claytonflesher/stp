class CreatePatientTherapistRelationships < ActiveRecord::Migration
  def change
    create_table :patient_therapist_relationships do |t|
      t.integer :patient_id
      t.integer :therapist_id

      t.timestamps null: false
    end

    add_index :patient_therapist_relationships, :patient_id
    add_index :patient_therapist_relationships, :therapist_id
    add_foreign_key :patient_therapist_relationships, :patients
    add_foreign_key :patient_therapist_relationships, :therapists
  end
end
