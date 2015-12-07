class Patient < ActiveRecord::Base
  has_secure_password

  validates :username,        
            presence:   true,
            uniqueness: true

  validates :email, 
            presence:   true,
            format:     /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/,
            uniqueness: true

  validates :zipcode,
            presence:   true,
            format:     /\A[-0-9]+\z/

  validates :former_religion, presence: true
  validates :description,     presence: true
  validates :distance,        presence: true

  has_many :therapists, through: :patient_therapist_relationships
  has_many :patient_therapist_relationships
end
