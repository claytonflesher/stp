require "securerandom"
class TherapistsPasswordResetsController < ApplicationController
  before_filter :ensure_therapist_not_signed_in

  def new
  end

  def create
    @therapist = Therapist.find_by(username: params[:username])
    if @therapist
      @therapist.password_reset_token = SecureRandom.hex(20)
      @therapist.save!
      TherapistMailer.reset_password(@therapist).deliver_now
      flash[:notice] = "An email has been sent to #{@therapist.email}."
    else
      flash.now[:alert] = "Email address not found."
      render :new
    end
  end

  def edit
  end

  def update
    if params[:therapist][:password] == params[:therapist][:password_confirmation]
      @therapist = Therapist.find_by(password_reset_token: params[:token])
      @therapist.save!
      flash[:notice] = "Password reset. Please sign in."
      redirect_to therapist_signin_path
    else
      flash.now[:alert] = "Password and password confirmation did not match."
      render :edit
    end
  end
end
