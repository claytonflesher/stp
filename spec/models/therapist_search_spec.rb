require 'rails_helper'

RSpec.describe TherapistSearch do
  before(:all) do 
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "111 Main St, New York, NY, 10001", [
        {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'address'      => 'New York, NY, USA',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )
    Geocoder::Lookup::Test.add_stub(
      "73110-111", [
        {
          'latitude'     => 35.45897739999999,
          'longitude'    => -97.4056928
        }
      ]
    )
    Geocoder::Lookup::Test.add_stub(
      "numbers1111", [
        {
          'latitude'     => 0,
          'longitude'    => 0
        }
      ]
    )
    @search    = TherapistSearch.new(FactoryGirl.create(:patient))
    @therapist = FactoryGirl.create(:therapist, verified_at: Time.now)
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
