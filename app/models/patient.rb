class Patient < ActiveRecord::Base
  has_secure_password
  geocoded_by :zipcode
  after_validation :geocode, if: ->(obj){ 
    obj.zipcode.present? && obj.zipcode_changed? 
  }

  acts_as_messageable :table_name => "messages",
                      :dependent  => :destroy

  validates :username,        
            presence:   true,
            uniqueness: true

  validates :email, 
            presence:   true,
            format:     /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/,
            uniqueness: true

  validates :zipcode,
            presence:   true,
            format:     /\A[-0-9 ]+\z/

  validates :former_religion, presence: true
  validates :description,     presence: true
  validates :distance,        presence: true

  def email=(email)
    write_attribute(:email, email.try(:downcase))
  end

  has_many :therapists, through: :patient_therapist_relationships
  has_many :patient_therapist_relationships
end
