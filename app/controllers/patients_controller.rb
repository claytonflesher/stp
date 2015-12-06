class PatientsController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:show, :update]
  before_filter :ensure_patient_not_signed_in, except: [:show, :update]

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.create(
      username:              params[:username],
      password:              params[:password],
      password_conformation: params[:password_confirmation],
      name:                  params[:name],
      phone:                 params[:phone],
      email:                 params[:email].downcase,
      zipcode:               params[:zipcode],
      gender:                params[:gender],
      former_religion:       params[:former_religion],
      description:           params[:description],
      distance:              params[:distance]
    )
    if @patient.id
      redirect_to patient_verify_path(patient_id: @patient.id)
    else
      render :new
    end
  end

  def show
    @patient = Patient.find(session[:patient_id])
  end

  def update
  end
end
