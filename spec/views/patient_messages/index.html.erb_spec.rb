require 'rails_helper'

RSpec.describe "patient_messages/index", type: :view do
  before(:each) do
    assign(:patient_messages, [
      PatientMessage.create!(),
      PatientMessage.create!()
    ])
  end

  it "renders a list of patient_messages" do
    render
  end
end
