require "securerandom"
class PatientsPasswordResetsController < ApplicationController
  before_filter :ensure_patient_not_signed_in

  def new
  end

  def create
    @patient = Patient.find_by(email: params[:email])
    if @patient
      @patient.password_reset_token = SecureRandom.hex(20)
      @patient.save!
      PatientMailer.reset_password(@patient).deliver_now
      flash[:notice] = "An email has been sent #{@patient.email}."
      redirect_to patient_signin_path
    else
      flash.now[:alert] = "Email address not found."
      render :new
    end
  end

  def edit
  end

  def update
    if params[:password] == params[:password_confirmation]
      @patient = Patient.find_by(password_reset_token: params[:token])
      @patient.password = params[:password]
      @patient.save!
      flash[:notice] = "Password reset. Please sign in."
      redirect_to patient_signin_path
    else
      flash.now[:alert] = "Password and password confirmation did not match."
      render :edit
    end
  end
end
