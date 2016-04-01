require "securerandom"

class TherapistsVerificationsController < ApplicationController
  before_filter :ensure_therapist_not_signed_in

  def new
    @therapist = Therapist.find(params[:therapist_id])
    @therapist.verification_token = SecureRandom.hex(20)
    @therapist.save!
    TherapistMailer.verify(@therapist).deliver_now
    flash[:notice] = "Thank you for submitting an application to become a therapist with the Secular Therapy Project. An administrator will be in contact with you about your application."
    redirect_to therapist_signin_path
  end

  def create
    @new_therapist = Therapist.find_by(verification_token: params[:token])
    @new_therapist.verified_at = Time.now
    @new_therapist.application_status = 'accepted'
    @new_therapist.save!
    TherapistMailer.confirm(@new_therapist).deliver_now
    flash[:notice] = "Email verified. New therapist emailed confirmation."
    redirect_to votes_path
  end

  def delete
    @denied_therapist = Therapist.find_by(verification_token: params[:token])
    @denied_therapist.verified_at = nil
    @denied_therapist.application_status = 'denied'
    @denied_therapist.save!
    flash[:notice] = "This therapist is still on the database, with a status set to 'denied'"
    redirect_to votes_path
  end
end
