FactoryGirl.define do
  factory :message do
    conversation

    topic 'Magic'
    body  "I don't think magic is a thing"
    sender_type   {'patient'}
    sender_id     {1}
    receiver_type {'therapist'}
    receiver_id   {1}
  end
end
