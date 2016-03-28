require 'rails_helper'

RSpec.describe Message, type: :model do
  before(:each) do
    @message = create(:message)
  end

  it 'has a conversation_id' do
    should validate_presence_of(:conversation_id)
    expect(@message.conversation_id).to be_an_integer
  end

  it 'has a topic' do
    should validate_presence_of(:topic)
    expect(@message.topic).to eq('Magic')
  end

  it 'has a body' do
    should validate_presence_of(:body)
    expect(@message.body).to eq ("I don't think magic is a thing")
  end

  it 'has a sender_type' do
    should validate_presence_of(:sender_type)
    expect(@message.sender_type).to eq('patient')
  end

  it 'has a sender_id' do
    should validate_presence_of(:sender_id)
    expect(@message.sender_id).to eq(1)
  end

  it 'has a receiver_type' do
    should validate_presence_of(:receiver_type)
    expect(@message.receiver_type).to eq('therapist')
  end

  it 'has a receiver_id' do
    should validate_presence_of(:receiver_id)
    expect(@message.receiver_id).to eq(1)
  end
end
