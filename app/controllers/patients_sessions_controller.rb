class PatientsSessionsController < ApplicationController
  before_filter :ensure_patient_not_signed_in, except: :destroy
  before_filter :ensure_patient_signed_in, only: :destroy

  # GET /patient_signin
  def new
    @patient = Patient.new
  end

  # POST /patient_signin
  def create
    @patient = Patient.where(
      "username = ? AND verified_at IS NOT NULL",
      params[:username]).first
    if @patient && @patient.authenticate(params[:password])
      session[:patient_id] = @patient.id
      redirect_to patient_dashboard_path(@patient.id)
    else
      flash.now[:alert] = "Email or password didn't match."
      render :new
    end
  end

  # signout
  def destroy
    reset_session
    redirect_to patient_signin_path
  end
end
