class TherapistsSessionsController < ApplicationController
  before_filter :ensure_therapist_not_signed_in, except: :destroy
  before_filter :ensure_therapist_signed_in, only: :destroy

  def new
    @therapist = Therapist.new
  end

  def create
    @therapist = Therapist.where(
      "username = ? AND verified_at IS NOT NULL",
      params[:username]).first
    if @therapist && @therapist.authenticate(params[:password])
      session[:therapist_id] = @therapist.id
      redirect_to therapist_dashboard_path(@therapist.id)
    else
      flash.now[:alert] = "Email or password didn't match."
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to therapist_signin_path
  end
end
