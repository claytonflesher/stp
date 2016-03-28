class Conversation < ActiveRecord::Base
  belongs_to :patient_therapist_relationship
  has_many   :messages
end
