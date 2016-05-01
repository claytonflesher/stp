require 'rails_helper'

RSpec.describe Patient, type: :model do
  before(:all) do 
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "73110-111", [
        {
          'latitude'     => 35.45897739999999,
          'longitude'    => -97.4056928
        }
      ]
    )
    Geocoder::Lookup::Test.add_stub(
      "numbers1111$@", [
        {
          'latitude'     => 0,
          'longitude'    => 0
        }
      ]
    )
  end
  describe Patient, '.username' do
    it do
      create(:patient)
      should validate_presence_of(:username)
      should validate_uniqueness_of(:username)
    end
  end

  describe Patient, ".email" do
    it "has a unique email" do
      patient = create(:patient)
      expect(patient).to be_valid
      patient_new = build(:patient)
      expect(patient_new).not_to be_valid
    end

    it do
      should validate_presence_of(:email)
      should allow_value("stuff@email.com").for(:email)
      should_not allow_value("stuff").for(:email)
    end
  end

  describe Patient, ".password" do
    it do
      should have_secure_password
    end
  end

  describe Patient, ".zipcode" do
    it do
      patient = build(:patient)
      should validate_presence_of(:zipcode)
      should allow_value(patient.zipcode).for(:zipcode)
      should_not allow_value("numbers1111$@").for(:zipcode)
    end
  end

  describe Patient, ".former_religion" do
    it do
      should validate_presence_of(:former_religion)
    end
  end

  describe Patient, ".description" do
    it do
      should validate_presence_of(:description)
    end
  end
end
