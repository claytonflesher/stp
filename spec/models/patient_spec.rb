require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "validates the username is present" do
    patient = build(:patient, username: nil)
    expect(patient).not_to                   be_valid
    expect(patient.errors[:username]).not_to be_empty
  end

  it "validates the username is unique" do
    patient1 = create(:patient)
    expect(patient1).to                       be_valid
    patient2 = build(:patient)
    expect(patient2).not_to                   be_valid
    expect(patient2.errors[:username]).not_to be_empty
  end
end
