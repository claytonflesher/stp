class Vote < ActiveRecord::Base

  validates :voter_id,
            presence: true,
            uniqueness: { scope: :votee_id }

  validates :votee_id, presence: true

  belongs_to :votee, class_name: "Therapist"
  belongs_to :voter, class_name: "Therapist"
end
