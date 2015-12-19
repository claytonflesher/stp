require 'rails_helper'

RSpec.describe "patient_messages/show", type: :view do
  before(:each) do
    @patient_message = assign(:patient_message, PatientMessage.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
