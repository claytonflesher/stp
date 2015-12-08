class PatientsSessionsController < ApplicationController
  before_filter :ensure_patient_not_signed_in, except: :destroy
  before_filter :ensure_patient_signed_in, only: :destroy

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.where(
      "username = ? AND verified_at IS NOT NULL",
      params[:username]).first
    if @patient && @patient.authenticate(params[:password])
      session[:patient_id] = @patient.id
      redirect_to patient_dashboard_path
    else
      flash.now[:alert] = "Email or password didn't match."
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to patient_signin_path
  end
end
