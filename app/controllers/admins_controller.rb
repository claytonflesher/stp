class AdminsController < ApplicationController
  before_filter :ensure_admin

  def index
    @dashboard = PendingDashboard.new(current_admin)
  end

  def show
    @admin = Therapist.find(session[:therapist_id])
  end
end
