class AdminsController < ApplicationController
  before_filter :ensure_admin

  def index
    @admins = Therapist.admins
  end

  def show
    @admin = Therapist.find(params[:therapist_id])
  end
end
