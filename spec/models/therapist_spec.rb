require 'rails_helper'

RSpec.describe Therapist, type: :model do
  describe Therapist, ".username" do
    it do
      create(:therapist)
      should validate_presence_of(:username)
      should validate_uniqueness_of(:username)
    end
  end

  describe Therapist, ".password" do
    it do
      should have_secure_password
    end
  end

  describe Therapist, ".email" do
    it "has a unique email" do
      therapist = create(:therapist)
      expect(therapist).to be_valid
      therapist_new = build(:therapist)
      expect(therapist_new).not_to be_valid
    end

    it do
      therapist = build(:therapist)
      should validate_presence_of(:email)
      should allow_value(therapist.email).for(:email)
      should_not allow_value("stuff").for(:email)
    end
  end

  describe Therapist, ".zipcode" do
    it do
      should validate_presence_of(:zipcode)
    end
  end

  describe Therapist, ".first_name" do
    it do
      should validate_presence_of(:first_name)
    end
  end

  describe Therapist, ".last_name" do
    it do
      should validate_presence_of(:last_name)
    end
  end

  describe Therapist, ".address" do
    it do
      should validate_presence_of(:address)
    end
  end

  describe Therapist, ".city" do
    it do
      should validate_presence_of(:city)
    end
  end

  describe Therapist, ".state" do
    it do
      should validate_presence_of(:state)
    end
  end

  describe Therapist, ".country" do
    it do
      should validate_presence_of(:country)
    end
  end

  describe Therapist, ".practice" do
    it do
      should validate_presence_of(:practice)
    end
  end

  describe Therapist, ".years_experience" do
    it do
      should validate_presence_of(:years_experience)
    end
  end

  describe Therapist, ".qualifications" do
    it do
      should validate_presence_of(:qualifications)
    end
  end

  describe Therapist, ".gender" do
    it do
      should validate_presence_of(:gender)
    end
  end

  describe Therapist, ".religion" do
    it do
      should validate_presence_of(:religion)
    end
  end

  describe Therapist, ".licenses" do
    it do
      should validate_presence_of(:licenses)
    end
  end

  describe Therapist, ".main_license" do
    it do
      should validate_presence_of(:main_license)
    end
  end

  describe Therapist, ".purpose" do
    it do
      should validate_presence_of(:purpose)
    end
  end

  describe Therapist, ".distance_counseling" do
    it "validates the presence of true or false" do
      therapist = build(:therapist, distance_counseling: nil)
      expect(therapist).not_to                              be_valid
      expect(therapist.errors[:distance_counseling]).not_to be_empty
    end
  end

  describe Therapist, "latitude" do
    it do
      therapist = create(:therapist)
      expect(therapist.latitude).to eq(40.7572638)
    end
  end

  describe Therapist, "longitude" do
    it do
      therapist = create(:therapist)
      expect(therapist.longitude).to eq(-73.9552266)
    end
  end

  it "has an admin?" do
    therapist = build(:therapist)
    expect(therapist.admin?).to eq(false)
    therapist.update_attribute :admin, true
    expect(therapist.admin?).to eq(true)
  end

  describe Therapist, ".full_name" do
    it do
      therapist = build(:therapist)
      expect(therapist.full_name).to eq("Sigmund Freud")
    end
  end

  describe Therapist, ".geo_address" do
    it do
      should validate_presence_of(:geo_address)
    end
  end
end

