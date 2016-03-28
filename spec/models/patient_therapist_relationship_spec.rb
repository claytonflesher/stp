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
  it "creates associations between therapists and patients" do
    create(:patient_therapist_relationship)
    expect(:patient_therapist_relationship).to be_valid
  end
end
