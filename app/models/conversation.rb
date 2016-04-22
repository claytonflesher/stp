class Conversation < ActiveRecord::Base

  validates :patient_therapist_relationship_id,
            presence: true,
            uniqueness: true

  belongs_to :patient_therapist_relationship
  has_many   :messages
  has_one    :therapist, through: :patient_therapist_relationship
  has_one    :patient, through: :patient_therapist_relationship
end
