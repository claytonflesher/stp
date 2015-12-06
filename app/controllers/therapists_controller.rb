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
end
