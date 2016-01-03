class TherapistTherapistSearchesController < ApplicationController
  before_filter :ensure_therapist_signed_in

  def new
    @search ||= TherapistSearch.new(current_therapist)
    @results = @search.find
  end

  def create
    @search = TherapistSearch.new(current_therapist)
    @search.set_distance(params[:distance])
    @results = @search.find
  end
end
