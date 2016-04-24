class PatientsController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:show, :update, :edit]
  before_filter :ensure_admin, only: [:destroy]

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
    @patient = Patient.find(params[:patient_id])
    if patient_logged_in?
      @search ||= TherapistSearch.new(current_patient)
      @results = @search.find
    end
  end

  def edit
    @patient = Patient.find(session[:patient_id])
  end

  def update
    if @patient.update(patient_params)
      flash.notice = "Profile successfully updated"
      redirect_to patient_dashboard_path(patient_id: current_patient.id)
    else
      render :edit 
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    redirect_to admins_path
  end
  
  private

  def patient_params
    params.require(:patient).permit(
      :username, :password, :password_confirmation, :name, :phone, :email,
      :zipcode, :gender, :former_religion, :description)
  end
end


