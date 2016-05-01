class Therapist < ActiveRecord::Base
  has_secure_password
  geocoded_by :geo_address

  after_validation :geocode, if: ->(obj){ 
    obj.geo_address.present? && obj.geo_address_changed? 
  }

  # Changing these from using the verified_at attribute to application_status
  # because verified_at does not account for a denied application
  scope :pending, -> { where(application_status: "pending").order("created_at DESC") }

  scope :current, -> { where(application_status: "active").order(:last_name) }

  scope :admins, -> { where(admin: true).order(:last_name) }

  scope :super_admins, -> { where(super_admin: true).order(:last_name) }


  def phone=(phone)
    write_attribute(:phone, phone.try(:gsub, /[^+\dx]/, ""))
  end

  def email=(email)
    write_attribute(:email, email.try(:downcase))
  end

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
  validates :distance_counseling, inclusion: { in: [true, false] }
  validates :purpose,             presence: true
  validates :geo_address,         presence: true

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
            presence:   true

  has_many :patient_therapist_relationships
  has_many :patients, through: :patient_therapist_relationships
  has_many :conversations, through: :patient_therapist_relationships
  has_many :cast_votes,     class_name: "Vote",
                            foreign_key: "voter_id"
  has_many :received_votes, class_name: "Vote",
                            foreign_key: "votee_id"

  def full_name
    [first_name, last_name].join(" ")
  end
end
