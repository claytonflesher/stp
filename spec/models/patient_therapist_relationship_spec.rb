require 'rails_helper'

RSpec.describe PatientTherapistRelationship, type: :model do
  before(:all) do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "111 Main St, New York, NY, 10001", [
        {
          'latitude'     => 40.7572638,
          'longitude'    => -73.9552266,
        }
      ]
    )
  end
  it "has a therapist_id" do
    ptr = create(:patient_therapist_relationship)
    should validate_presence_of(:therapist_id)
    should validate_uniqueness_of(:therapist_id).scoped_to(:patient_id)
    expect(ptr.therapist_id).to be_an_integer
  end

  it "has a patient_id" do
    ptr = create(:patient_therapist_relationship)
    should validate_presence_of(:patient_id)
    should validate_uniqueness_of(:patient_id).scoped_to(:therapist_id)
    expect(ptr.patient_id).to be_an_integer
  end
end
