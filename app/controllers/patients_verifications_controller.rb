require "securerandom"

class PatientsVerificationsController < ApplicationController
  before_filter :ensure_patient_not_signed_in
  before_filter :ensure_therapist_not_signed_in

  def new
    @patient = Patient.find(params[:patient_id])
    @patient.verification_token = SecureRandom.hex(20)
    @patient.save!
    PatientMailer.verify(@patient).deliver_now
    flash[:notice] = "A verification email was sent to the email you provided. Please click on the link provided in it to complete your sign up."
    redirect_to root_path
  end

  def create
    @patient = Patient.find_by(verification_token: params[:token])
    @patient.verified_at = Time.now
    @patient.save!
    flash[:notice] = "Email verified. Please sign in."
    redirect_to patient_signin_path
  end
end
