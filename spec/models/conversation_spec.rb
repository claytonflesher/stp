require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it 'has a patient_therapist_relationship_id' do
    conv = create(:conversation)
    should validate_presence_of(:patient_therapist_relationship_id)
    should validate_uniqueness_of(:patient_therapist_relationship_id)
    expect(conv.patient_therapist_relationship_id).to be_an_integer
  end
end
