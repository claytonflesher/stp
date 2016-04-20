class TherapistSearchesController < ApplicationController
  before_filter :ensure_user_signed_in

  def show
    @therapist_search ||= TherapistSearch.new(current_user)
    @therapists         = @therapist_search.find
  end

  def update
    @therapist_search ||= TherapistSearch.new(current_user)
    if params[:distance]
      @therapist_search.set_distance(params[:distance])
    end
    if params[:address]
      @therapist_search.set_location(params[:address])
    end
    @therapists = @therapist_search.find
    if @therapists.empty?
      flash[:alert] = "No therapists found in this area. Please try varying your search."
    end
    render :show
  end
end
