require 'rails_helper'

RSpec.describe "patient_messages/new", type: :view do
  before(:each) do
    assign(:patient_message, PatientMessage.new())
  end

  it "renders new patient_message form" do
    render

    assert_select "form[action=?][method=?]", patient_messages_path, "post" do
    end
  end
end
