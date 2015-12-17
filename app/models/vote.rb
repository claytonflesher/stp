class Vote < ActiveRecord::Base

  belongs_to :votee, class_name: "Therapist"
  belongs_to :voter, class_name: "Therapist"
end
