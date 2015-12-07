require 'rails_helper'

RSpec.describe PatientTherapistRelationship, type: :model do
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
