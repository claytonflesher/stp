require 'rails_helper'

RSpec.describe "patient_messages/edit", type: :view do
  before(:each) do
    @patient_message = assign(:patient_message, PatientMessage.create!())
  end

  it "renders the edit patient_message form" do
    render

    assert_select "form[action=?][method=?]", patient_message_path(@patient_message), "post" do
    end
  end
end
