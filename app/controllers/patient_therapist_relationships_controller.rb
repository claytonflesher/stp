class PatientTherapistRelationshipsController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:new]

  def create
    @relationship = PatientTherapistRelationship.create(patient_therapist_relationship_params)
    if @relationship.id
      redirect_to relationship_messages_path
    else
      redirect_to patient_dashboard_path
    end
  end

  def destroy
    @relationship = PatientTherapistRelationship.where(patient_id: params[:patient_id], therapist_id: params[:therapist_id])
  end

  private

  def patient_therapist_relationship_params
    params.permit(:patient_id, :therapist_id)
  end
end
