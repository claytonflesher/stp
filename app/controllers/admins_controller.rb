class AdminsController < ApplicationController
  before_filter :ensure_admin

  def index
    @admins = Therapist.find_by admin: true
  end

  def show
    @admin = Therapist.find(session[:therapist_id])
  end
end
