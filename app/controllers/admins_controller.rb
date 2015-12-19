class AdminsController < ApplicationController
  before_filter :ensure_admin

  def index
    @admins = Admin.find_each
  end

  def show
    @admin = Therapist.find(session[:therapist_id])
  end
end
