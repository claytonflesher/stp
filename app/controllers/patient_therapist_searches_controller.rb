class PatientTherapistSearchesController < ApplicationController
  before_filter :ensure_patient_signed_in

  def new
    @search ||= TherapistSearch.new(current_patient)
    @results = @search.find
  end

  def create
    @search = TherapistSearch.new(current_patient)
    @search.set_distance(params[:distance])
    @results = @search.find
  end
end
