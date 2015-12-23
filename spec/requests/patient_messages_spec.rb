require 'rails_helper'

RSpec.describe "PatientMessages", type: :request do
  describe "GET /patient_messages" do
    it "works! (now write some real specs)" do
      get patient_messages_path
      expect(response).to have_http_status(200)
    end
  end
end
