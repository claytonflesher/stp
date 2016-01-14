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

  #POST /accept_connection_request
  def update
    @relationship = PatientTherapistRelationship.find(params[:id])
    if @relationship.update(patient_therapist_relationship_params)
      flash.notice = "Connection request accepted"
    else
      flash.notice = "Failed to accept connection request"
    end
    redirect_to patient_dashboard_path(@relationship.patient_id)
  end

  # POST /deny_connection_request
  def destroy

  end

  def only_two
    #create a relationship between the admins and this patient and update it so it is considered accepted.  This will allow the patient to approach the admins and vise versa 
    #view should have a form that allows the patient to voice their concerns about getting denied
  end

  def not_first_request
    flash.notice = "You have already submitted a connection request to this therapist"
    redirect_to therapist_dashboard_path(params[:therapist_id])
  end

  private

  def patient_therapist_relationship_params
    params.require(:patient_therapist_relationship).permit(:patient_id, :therapist_id)
  end
    
end
