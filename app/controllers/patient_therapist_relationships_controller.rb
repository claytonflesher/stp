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
      elsif @relationship.status = "deny"
        flash.notice = "Connection request rejected"
      end
    else
      flash.notice = "Failed to update connection request"
    end
    redirect_to patient_dashboard_path(@relationship.patient_id)
  end

  def only_two
    #create a relationship between the admins and this patient and update it so it is considered accepted.  This will allow the patient to approach the admins and vise versa 
    #view should have a form that allows the patient to voice their concerns about getting denied
  end

  private

  def patient_therapist_relationship_params
    params.permit(:patient_id, :therapist_id, :status)
  end
    
end
