require 'rails_helper'

RSpec.describe Therapist, type: :model do
  it "validates the presence of a #username" do
    therapist = build(:therapist, username: nil)
    expect(therapist).not_to                   be_valid
    expect(therapist.errors[:username]).not_to be_empty
  end

  it "validates the uniqueness of a #username" do
    therapist1 = create(:therapist)
    expect(therapist1).to                       be_valid
    therapist2 = build(:therapist)
    expect(therapist2).not_to                   be_valid
    expect(therapist2.errors[:username]).not_to be_empty
  end

  it "validates the presence of a #password" do
    therapist = build(:therapist, password: nil)
    expect(therapist).not_to                   be_valid
    expect(therapist.errors[:password]).not_to be_empty
  end

  it "has an encrypted #password" do
    therapist = create(:therapist)
    therapist = Therapist.first
    expect(therapist.password).not_to                       eq("aCigarisjustaCigar")
    expect(therapist.authenticate("aCigarisjustaCigar")).to be_truthy
    expect(therapist.authenticate("foo_bar")).to            be_falsey
  end

  it "validates the presence of an #email" do
    therapist = build(:therapist, email: nil)
    expect(therapist).not_to                be_valid
    expect(therapist.errors[:email]).not_to be_empty
  end

  it "validates the uniqueness of an #email" do
    therapist1 = create(:therapist)
    expect(therapist1).to be_valid
    therapist2 = build(:therapist)
    expect(therapist2).not_to be_valid
  end

  it "validates the format of an email" do
    therapist = build(:therapist, email: "hidey ho, neightbor")
    expect(therapist).not_to                be_valid
    expect(therapist.errors[:email]).not_to be_empty
  end

  it "validates the presence of a #zipcode" do
    therapist = build(:therapist, zipcode: nil)
    expect(therapist).not_to                  be_valid
    expect(therapist.errors[:zipcode]).not_to be_empty
  end

  it "validates the presence of a #first_name" do
    therapist = build(:therapist, first_name: nil)
    expect(therapist).not_to                     be_valid
    expect(therapist.errors[:first_name]).not_to be_empty
  end

  it "validates the presence of a #last_name" do
    therapist = build(:therapist, last_name: nil)
    expect(therapist).not_to                    be_valid
    expect(therapist.errors[:last_name]).not_to be_empty
  end

  it "validates the presence of an #address" do
    therapist = build(:therapist, address: nil)
    expect(therapist).not_to                    be_valid
    expect(therapist.errors[:address]).not_to   be_empty
  end

  it "validates the presence of a #city" do
    therapist = build(:therapist, city: nil)
    expect(therapist).not_to                    be_valid
    expect(therapist.errors[:city]).not_to      be_empty
  end

  it "validates the presence of a #state" do
    therapist = build(:therapist, state: nil)
    expect(therapist).not_to                    be_valid
    expect(therapist.errors[:state]).not_to     be_empty
  end

  it "validates the presence of a #country" do
    therapist = build(:therapist, country: nil)
    expect(therapist).not_to                    be_valid
    expect(therapist.errors[:country]).not_to   be_empty
  end

  it "validates the presence of a #practice" do
    therapist = build(:therapist, practice: nil)
    expect(therapist).not_to                    be_valid
    expect(therapist.errors[:practice]).not_to  be_empty
  end

  it "validates the presence of a #years_experience" do
    therapist = build(:therapist, years_experience: nil)
    expect(therapist).not_to                           be_valid
    expect(therapist.errors[:years_experience]).not_to be_empty
  end

  it "validates the presence of a #qualifications" do
    therapist = build(:therapist, qualifications: nil)
    expect(therapist).not_to                         be_valid
    expect(therapist.errors[:qualifications]).not_to be_empty
  end

  it "validates the presence of a #gender" do
    therapist = build(:therapist, gender: nil)
    expect(therapist).not_to                 be_valid
    expect(therapist.errors[:gender]).not_to be_empty
  end

  it "validates the presence of a #religion" do
    therapist = build(:therapist, religion: nil)
    expect(therapist).not_to                   be_valid
    expect(therapist.errors[:religion]).not_to be_empty
  end

  it "validates the presence of a #licenses" do
    therapist = build(:therapist, licenses: nil)
    expect(therapist).not_to                   be_valid
    expect(therapist.errors[:licenses]).not_to be_empty
  end

  it "validates the presence of a #main_license" do
    therapist = build(:therapist, main_license: nil)
    expect(therapist).not_to                       be_valid
    expect(therapist.errors[:main_license]).not_to be_empty
  end

  it "validates the presence of a #distance_counseling" do
    therapist = build(:therapist, distance_counseling: nil)
    expect(therapist).not_to                              be_valid
    expect(therapist.errors[:distance_counseling]).not_to be_empty
  end

  it "validates the presence of a #purpose" do
    therapist = build(:therapist, purpose: nil)
    expect(therapist).not_to                  be_valid
    expect(therapist.errors[:purpose]).not_to be_empty
  end

  it "has a latitude" do
    therapist = create(:therapist)
    expect(therapist.latitude).to eq(40.7572638)
  end

  it "has a longitude" do
    therapist = create(:therapist)
    expect(therapist.longitude).to eq(-73.9552266)
  end

  it "has an admin?" do
    therapist = create(:therapist)
    expect(therapist.admin?).to eq(false)
    therapist.update_attribute :admin, true
    expect(therapist.admin?).to eq(true)
  end
end
