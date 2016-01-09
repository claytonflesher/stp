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
    create(:patient)
    patient   = Patient.last
    create(:therapist)
    therapist = Therapist.last
    association = PatientTherapistRelationship.new(
      patient_id: patient.id,
      therapist_id: therapist.id
    )
    association.save

    expect(association).to be_valid
    expect(patient.therapists.first).to eq(therapist)
    expect(therapist.patients.first).to eq(patient)
  end
end
