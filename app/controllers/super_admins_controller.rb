class SuperAdminsController < ApplicationController
  before_filter :ensure_super_admin

  def index
    @therapists = Therapist.find_each
  end

  def show
    @therapist = Therapist.find(params[:therapist_id])
  end

  def update
    @therapist = Therapist.find(params[:therapist_id])
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
      @therapist.save
    end
    redirect_to super_admins_index_path
  end
end
