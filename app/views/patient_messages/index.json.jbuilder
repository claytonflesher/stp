json.array!(@patient_messages) do |patient_message|
  json.extract! patient_message, :id
  json.url patient_message_url(patient_message, format: :json)
end
