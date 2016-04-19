class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def ensure_is_your_message
    unless is_an_admin?
      conversation = Conversation.find(message_params[:conversation_id])
      if patient_logged_in?
        unless session[:patient_id] ==
            conversation.patient_therapist_relationship.patient_id
          redirect_to patient_dashboard_path
        end
      elsif therapist_logged_in?
        unless session[:therapist_id] ==
            conversation.patient_therapist_relationship.therapist_id
          redirect_to therapist_dashboard_path
        end
      else
        redirect_to home_path
      end
    end
  end

  def ensure_patient_signed_in
    unless is_a_super_admin?
      unless patient_logged_in?
        redirect_to patient_signin_path
      end
    end
  end

  def ensure_therapist_signed_in
    unless therapist_logged_in?
      redirect_to therapist_signin_path
    end
  end

  def ensure_patient_not_signed_in
    if patient_logged_in?
      redirect_to patient_dashboard_path(current_patient.id)
    end
  end

  def ensure_therapist_not_signed_in
    if therapist_logged_in?
      redirect_to therapist_dashboard_path(current_therapist.id)
    end
  end

  def ensure_admin
    unless is_an_admin?
      redirect_to therapist_signin_path
    end
  end

  def ensure_super_admin
    unless is_a_super_admin?
      redirect_to therapist_signin_path
    end
  end

  def ensure_relationship_exists
    unless is_a_super_admin?
      unless patient_therapist_relationship_exists?
        if patient_logged_in?
          redirect_to patient_dashboard_path(current_patient.id)
        elsif therapist_logged_in?
          redirect_to therapist_dashboard_path(current_patient.id)
        else
          # Not logged in
          redirect_to home_path
        end
      end
    end
  end

  def current_patient
    if session[:patient_id]
      @patient = Patient.find(session[:patient_id])
    else
      @patient = nil
    end
    @patient
  end

  def current_therapist
    if session[:therapist_id]
      @therapist = Therapist.find(session[:therapist_id])
    else
      @therapist = nil
    end
    @therapist
  end

  def is_an_admin?
    if therapist_logged_in?
      @therapist.admin?
    else
      false
    end
  end

  def is_a_super_admin?
    if therapist_logged_in?
      @therapist.super_admin?
    else
      false
    end
  end

  def patient_logged_in?
    current_patient != nil
  end

  def therapist_logged_in?
    current_therapist != nil
  end

  def current_patient_therapist_relationship
    if therapist_logged_in?
      patient_id   = params[:patient_id]
      therapist_id = session[:therapist_id]
    elsif patient_logged_in?
      patient_id   = session[:patient_id]
      therapist_id = params[:therapist_id]
    else
      return nil
    end
    @relationship ||= PatientTherapistRelationship.find_by(
      patient_id: patient_id,
      therapist_id: therapist_id
    )
  end

  def patient_therapist_relationship_exists?
    current_patient_therapist_relationship != nil
  end

  def cast_votes
    @cast_votes = Vote.where(voter_id: current_therapist.id)
  end

  def voted_on?(therapist)
    cast_votes.each do |vote|
      if therapist.id == vote.votee_id
        return true
      end
    end
    return false
  end

  helper_method :current_patient, 
                :current_therapist, 
                :is_an_admin?,
                :is_a_super_admin?,
                :patient_logged_in?, 
                :therapist_logged_in?,
                :voted_on?
end
