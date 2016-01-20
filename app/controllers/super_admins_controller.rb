class SuperAdminsController < ApplicationController
  before_filter :ensure_super_admin
  skip_before_filter :ensure_super_admin, :only => [:message]

  def index
    @current_therapists = Therapist.current
    @admins             = Therapist.admins
    @super_admins       = Therapist.super_admins
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
    redirect_to super_admins_path
  end

  def message
    # Patients have the option of sending a message to the admins when they have exceeded the allowed monthly request limit
    @patient = Patient.find(params[:patient_id])
    @admins = Therapist.where("super_admin = ?", true)
    @message_body = "Patient exceeded two connection requests in 30 days: " + params[:body]
    
    @admins.each do |a|
      @patient.send_message(a, "Exceeded Requests", params[:body])
    end

    flash.notice = "Your message has been sent.  The site administrators will review your concern and contact you soon."
    redirect_to patient_dashboard_path(params[:patient_id])
  end

end
