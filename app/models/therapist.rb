class Therapist < ActiveRecord::Base
  has_secure_password
  geocoded_by :geo_address
  acts_as_messageable :group_messages => true

  after_validation :geocode, if: ->(obj){ 
    obj.geo_address.present? && obj.geo_address_changed? 
  }

  scope :pending, -> { where(verified_at: nil).order("created_at DESC") }

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

  def geo_address
    if address != ""
      if state != "Not Applicable"
        geo_address = [address, city, state, zipcode].join(", ")
      else
        geo_address = [address, city, country, zipcode].join(", ")
      end
      geo_address
    end
  end

  has_many :patients, through: :patient_therapist_relationships
  has_many :patient_therapist_relationships
end
