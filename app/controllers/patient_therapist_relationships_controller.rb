class PatientTherapistRelationshipsController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:new, :create]
  before_filter :ensure_admin, only: [:destroy, :index]

  def index
    @relationships = PatientTherapistRelationship.all
  end

  def new
    @relationship = PatientTherapistRelationship.new
  end

  def create
    @relationship = PatientTherapistRelationship.create(patient_therapist_relationship_params)
    if @relationship.id
      redirect_to create_conversation_path(
        patient_therapist_relationship_id: @relationship.id,
        patient_id:   params[:patient_id],
        therapist_id: params[:therapist_id]
      )
    else
      redirect_to patient_dashboard_path(patient_id: params[:patient_id])
    end
  end

  def destroy
    @relationship = PatientTherapistRelationship.find_by(patient_id: params[:patient_id], therapist_id: params[:therapist_id])
    if @relationship.id
      @relationship.delete!
    end
    redirect_to relationship_index_path
  end

  private

  def patient_therapist_relationship_params
    params.permit(:patient_id, :therapist_id)
  end
end
