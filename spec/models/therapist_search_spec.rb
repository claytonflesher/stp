require 'rails_helper'

RSpec.describe TherapistSearch do
  before(:all) do 
    @search    = TherapistSearch.new(FactoryGirl.create(:patient))
    @therapist = FactoryGirl.create(:therapist)
  end

  after(:all) do
    @therapist.delete
  end
  describe Therapist, ".searcher" do
    it do
      expect(@search.searcher.name).to eq(
        FactoryGirl.build(:patient).name
      )
    end
  end

  describe Therapist, ".distance" do
    it do
      expect(@search.distance).to eq(50)
    end
  end

  describe Therapist, ".set_distance" do
    it do
      @search.set_distance(50)
      expect(@search.distance).to eq(50)
      @search.set_distance(2000)
      expect(@search.distance).to eq(2000)
    end
  end

  describe Therapist, ".find" do
    it do
      @search.set_distance(50)
      expect(@search.find).to be_empty
      @search.set_distance(2000)
      expect(@search.find).not_to be_empty
    end
  end
end
