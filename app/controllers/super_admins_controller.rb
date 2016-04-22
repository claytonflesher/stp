class SuperAdminsController < ApplicationController
  before_filter :ensure_super_admin

  def index
    @current_therapists = Therapist.current
    @admins             = Therapist.admins
    @super_admins       = Therapist.super_admins
  end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def edit
    @therapist = Therapist.find(params[:id])
  end

  def update
    @therapist = Therapist.find(params[:id])
    if params[:super_admin] == true
      @therapist.admin = true
      @therapist.super_admin = true
      @therapist.save!
    elsif params[:admin] == true
      @therapist.super_admin = false
      @therapist.admin = true
      @therapist.save!
    else
      @therapist.super_admin = false
      @therapist.admin = false
      @therapist.save!
    end
    redirect_to super_admins_path
  end
end
