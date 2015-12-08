require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "validates the presence of a #username" do
    patient = build(:patient, username: nil)
    expect(patient).not_to                    be_valid
    expect(patient.errors[:username]).not_to  be_empty
  end

  it "validates the uniqueness of a #username" do
    patient1 = create(:patient)
    expect(patient1).to                       be_valid
    patient2 = build(:patient)
    expect(patient2).not_to                   be_valid
    expect(patient2.errors[:username]).not_to be_empty
  end

  it "validates the presence of a #password" do
    patient = build(:patient, password: nil)
    expect(patient).not_to                   be_valid
    expect(patient.errors[:password]).not_to be_empty
  end

  it "has an encrypted #password" do
    patient = create(:patient)
    patient = Patient.first
    expect(patient.password).not_to              eq("ABC123abc")
    expect(patient.authenticate("ABC123abc")).to be_truthy
    expect(patient.authenticate("gibberish")).to be_falsey
  end

  it "validates the presence of an #email" do
    patient = build(:patient, email: nil)
    expect(patient).not_to                be_valid
    expect(patient.errors[:email]).not_to be_empty
  end

  it "validates the uniqueness of an #email" do
    patient1 = create(:patient)
    expect(patient1).to be_valid
    patient2 = build(:patient)
    expect(patient2).not_to be_valid
  end

  it "validates the format of an #email" do
    patient = build(:patient, email: "wakka wakka dot wakka")
    expect(patient).not_to                be_valid
    expect(patient.errors[:email]).not_to be_empty
  end

  it "validates the presence of a #zipcode" do
    patient = build(:patient, zipcode: nil)
    expect(patient).not_to                  be_valid
    expect(patient.errors[:zipcode]).not_to be_empty
  end

  it "validates the format of a #zipcode" do
    patient = build(:patient, zipcode: "867530niiine")
    expect(patient).not_to                  be_valid
    expect(patient.errors[:zipcode]).not_to be_empty
  end

  it "validates the presence of #former_religion" do
    patient = build(:patient, former_religion: nil)
    expect(patient).not_to                          be_valid
    expect(patient.errors[:former_religion]).not_to be_empty
  end

  it "validates the presence of #description" do
    patient = build(:patient, description: nil)
    expect(patient).not_to                          be_valid
    expect(patient.errors[:description]).not_to be_empty
  end

  it "validates the presence of #distance" do
    patient = build(:patient, distance: nil)
    expect(patient).not_to                          be_valid
    expect(patient.errors[:distance]).not_to be_empty
  end

  it "has a lattitude" do
    patient = create(:patient)
    expect(patient.latitude).to eq(22.3909672)
  end

  it "has a longitude" do
    patient = create(:patient)
    expect(patient.longitude).to eq(-83.9400696)
  end
end
