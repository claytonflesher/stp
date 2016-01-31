require "securerandom"

class TherapistsVerificationsController < ApplicationController
  before_filter :ensure_therapist_not_signed_in

  def new
    @therapist = Therapist.find(params[:therapist_id])
    @therapist.verification_token = SecureRandom.hex(20)
    @therapist.save!
    TherapistMailer.verify(@therapist).deliver_now
    redirect_to votes_path
  end

  def create
    @therapist = Therapist.find_by(verification_token: params[:token])
    @therapist.verified_at = Time.now
    @therapist.save!
    TherapistMailer.confirm(@therapist).deliver_now
    flash[:notice] = "Email verified. New therapist emailed confirmation."
    redirect_to therapist_signin_path
  end
end
