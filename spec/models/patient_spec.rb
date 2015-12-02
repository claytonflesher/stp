require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "validates the username is present" do
    patient = build(:patient, username: nil)
    expect(patient).not_to                   be_valid
    expect(patient.errors[:username]).not_to be_empty
  end
end
