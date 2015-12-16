class AdminsController < ApplicationController
  before_filter :ensure_admin

  def index
    @pending_therapists = Therapist.pending
  end

  def show
    @admin = Therapist.find(session[:therapist_id])
  end
end
