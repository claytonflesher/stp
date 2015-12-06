class Therapist < ActiveRecord::Base
  has_secure_password
  geocoded_by :geo_address
  after_validation :geocode
  
  geocoded_by :zipcode

  validates :first_name,          presence: true
  validates :last_name,           presence: true
  validates :address,             presence: true
  validates :city,                presence: true
  validates :state,               presence: true
  validates :country,             presence: true
  validates :practice,            presence: true
  validates :years_experience,    presence: true
  validates :qualifications,      presence: true
  validates :gender,              presence: true
  validates :religion,            presence: true
  validates :licenses,            presence: true
  validates :main_license,        presence: true
  validates :distance_counseling, presence: true
  validates :purpose,             presence: true

  validates :username, 
            presence:   true,
            uniqueness: true

  validates :email,
            presence:   true,
            format:     /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/,
            uniqueness: true

  validates :phone, 
            presence:   true,
            format:     /\A[+0-9x]+\z/

  validates :zipcode,
            presence:   true,
            format:     /\A[-0-9 ]+\z/

  has_many :patients, through: :patient_therapist_relationships
  has_many :patient_therapist_relationships
end
