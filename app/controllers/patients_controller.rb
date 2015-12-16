class PatientsController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:show, :update, :edit]
  before_filter :ensure_patient_not_signed_in, except: [:show, :update, :edit]

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.create(patient_params)
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
    if @patient.update(patient_params)
      redirect_to patient_dashboard_path, notice: 'Profile was successfully updated'
    else
      render :edit 
    end
  end

  def edit
    @patient = Patient.find(session[:patient_id])
  end

  private

  def patient_params
    params.require(:patient).permit(:username, :password, :password_confirmation, :name, :phone, :email, :zipcode, :gender, :former_religion, :description, :distance)
  end
end

