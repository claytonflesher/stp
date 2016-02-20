class PatientTherapistRelationshipsController < ApplicationController

  before_filter :ensure_patient_signed_in, only: [:create]
  before_filter :ensure_therapist_signed_in, only: [:update]
  before_filter :ensure_only_two_per_month, only: [:create]
  before_filter :ensure_first_request, only: [:create]

  #POST /new_connection_request
  def create
    @relationship = PatientTherapistRelationship.create(patient_therapist_relationship_params)
    if @relationship.id
      flash.notice = "Connection request sent.  You will be notified when this request has been accepted"
      redirect_to therapist_dashboard_path(@relationship.therapist_id)
    else
      flash.notice = "Connection request failed."
    end
  end

  def update
    @relationship = PatientTherapistRelationship.where("patient_id = ? and therapist_id = ?", params[:patient_id], params[:therapist_id]).first
    if @relationship.update(patient_therapist_relationship_params)
      if @relationship.status == "accept"
        # Mail an alert to patient
        flash.notice = "Connection request accepted"
      elsif @relationship.status == "deny"
        @admins = Therapist.where(super_admin: true)
        @therapist = Therapist.find(params[:therapist_id])
        @message_body = "Connection request denied: " + params[:comment]
        @admins.each do |a|
          @therapist.send_message(a, "Denied", @message_body)
        end

        @patient = Patient.find(params[:patient_id])
        @therapist.send_message(@patient, "Denied", @message_body)

        flash.notice = "Connection request rejected"
      end
    else
      flash.notice = "Failed to update connection request"
    end
    redirect_to patient_dashboard_path(@relationship.patient_id)
  end

  def exceeded_requests
    @patient = current_patient

    # The patient should only see the form to message the admins if they have not messaged them yet.
    @godvirus = Therapist.where("username = ?", "godvirus").first
    @message = @patient.messages.where("received_messageable_id = ?", @godvirus.id).first
    if @message == nil
      @show_form = true
    else
      @show_form = false
    end
  end

  def admin_message
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

  private

  def patient_therapist_relationship_params
    params.permit(:patient_id, :therapist_id, :status)
  end
    
end
