class PatientsController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:show, :update, :edit]
  before_filter :ensure_patient_not_signed_in, except: [:show, :update, :edit]

  # To see a patient's profile, you must be signed in as a therapist, and the patient must have sent the logged in therapist a connection request #
  before_filter :ensure_therapist_signed_in, only: [:profile]
  before_filter :patient_therapist_relationship_exists(params[:patient_id], session[:therapist_id]), only: [:profile]
  
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

  def profile
  end

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_dashboard_path, notice: 'Profile was successfully updated' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
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

