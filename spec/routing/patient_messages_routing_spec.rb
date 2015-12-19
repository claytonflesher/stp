require "rails_helper"

RSpec.describe PatientMessagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/patient_messages").to route_to("patient_messages#index")
    end

    it "routes to #new" do
      expect(:get => "/patient_messages/new").to route_to("patient_messages#new")
    end

    it "routes to #show" do
      expect(:get => "/patient_messages/1").to route_to("patient_messages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/patient_messages/1/edit").to route_to("patient_messages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/patient_messages").to route_to("patient_messages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/patient_messages/1").to route_to("patient_messages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/patient_messages/1").to route_to("patient_messages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/patient_messages/1").to route_to("patient_messages#destroy", :id => "1")
    end

  end
end
