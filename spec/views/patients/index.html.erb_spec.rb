require 'rails_helper'

RSpec.describe "patients/index", type: :view do
  before(:each) do
    assign(:patients, [
      Patient.create!(),
      Patient.create!()
    ])
  end

  it "renders a list of patients" do
    render
  end
end
