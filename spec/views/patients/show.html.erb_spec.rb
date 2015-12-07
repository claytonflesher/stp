require 'rails_helper'

RSpec.describe "patients/show", type: :view do
  before(:each) do
    @patient = assign(:patient, Patient.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
