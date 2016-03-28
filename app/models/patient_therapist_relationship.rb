class PatientTherapistRelationship < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist
  has_one    :conversation
  has_many   :messages, through: :conversation

  
  validates :patient_id,
            presence: true,
            uniqueness: { scope: :therapist_id }

  validates :therapist_id,
            presence: true,
            uniqueness: { scope: :patient_id }
end
