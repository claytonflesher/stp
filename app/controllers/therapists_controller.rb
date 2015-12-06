class TherapistsController < ApplicationController
  before_filter :ensure_therapist_signed_in, only: [:show, :update]
  before_filter :ensure_therapist_not_signed_in, expect: [:show, :update]

  def new
    @therapist = Therapist.new
  end


  def create
    @therapist = Therapist.create(
      username:              params[:username],
      password:              params[:password],
      password_confirmation: params[:password_confirmation],
      first_name:            params[:first_name],
      last_name:             params[:last_name],
      phone:                 params[:phone].gsub(/[^+\dx]/, ""),
      email:                 params[:email],
      address:               [
        params[:address1], params[:address2], params[:address3]
      ].join(' ').strip, 
      city:                  params[:city],
      state:                 params[:state],
      country:               params[:country],
      zipcode:               params[:zipcode],
      practice:              params[:practice],
      years_experience:      params[:years_experience],
      qualifications:        params[:qualifications],
      website:               params[:website],
      gender:                params[:gender],
      religion:              params[:religion],
      previous_religion:     params[:previous_religion],
      licenses:              params[:licenses],
      main_license:          params[:main_license],
      distance_counseling:   params[:distance_counseling],
      languages:             params[:languages],
      purpose:               params[:purpose],
      public_description:    params[:public_description],
      secular_evidence:      params[:secular_evidence]
    )
    if @therapist.id
      set_location_info
      @therapist.save!
      redirect_to therapist_verify_path(therapist_id: @therapist.id)
    else
      render :new
    end
  end

  def show
    @therapist = Therapist.find(session[:therapist_id])
  end

  def update
  end

  private

  def set_location_info
    if @therapist.address != ""
      if @therapist.state != "Not Applicable"
        normalized_address = normalize_address_with_state
      else
        normalized_address = normalize_address_without_state
      end
      set_geocoordinates(normalized_address)
    end
  end

  def normalize_address_with_state
    [@therapist.address, @therapist.city, @therapist.state, @therapist.zipcode]
      .join(", ")
  end

  def normalize_address_without_state
    [@therapist.address, @therpist.city, @therapist.country, @therapist.zipcode]
      .join(", ")
  end

  def set_geocoordinates(normalized_address)
    geo_coordinates = Geocoder.coordinates(normalized_address)
    @therapist.lattitude = geo_coordinates[0]
    @therapist.longitude = geo_coordinates[1]
  end
end
