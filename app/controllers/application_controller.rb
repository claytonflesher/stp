class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_patient_signed_in
    unless current_patient
      session[:return_to] = request.url
      redirect_to patient_signin_path
    end
  end

  def ensure_therapist_signed_in
    unless current_therapist
      session[:return_to] = request.url
      redirect_to therapist_signin_path
    end
  end

  def ensure_patient_not_signed_in
    if current_patient
      redirect_to patient_dashboard_path
    end
  end

  def ensure_therapist_not_signed_in
    if current_therapist
      redirect_to therapist_dashboard_path
    end
  end

  def ensure_relationship_exists
    unless patient_therapist_relationship_exists
      session[:return_to] = request.url
      if current_patient
        redirect_to patient_dashboard_path
      elsif current_therapist
        redirect_to therapist_dashboard_path
      else
        # Not logged in
        redirect_to home_path
      end
    end
  end

  def ensure_connection_accepted
    unless connection_accepted
      session[:return_to] = request.url
      if current_patient
        redirect_to patient_dashboard_path
      elsif current_therapist
        redirect_to therapist_dashboard_path
      else
        # Not logged in
        redirect_to home_path
      end
    end
  end

  def current_patient
    session[:patient_id] && Patient.find(session[:patient_id])
    if session[:patient_id] && Patient.find(session[:patient_id])
      @patient = Patient.find(session[:patient_id])
    end
  end

  def current_therapist
    session[:therapist_id] && Therapist.find(session[:therapist_id])
  end

  def patient_therapist_relationship_exists
    if current_therapist
      patient_id = params[:patient_id]
      therapist_id = session[:therapist_id]
    elsif current_patient
      patient_id = session[:patient_id]
      therapist_id = params[:patient_id]
    else
      # Not logged in
      return false
    end
    PatientTherapistRelationship.where(patient_id: patient_id, therapist_id: therapist_id) != [] 
  end

  def patient_logged_in?
    current_patient != nil
  end

  def therapist_logged_in?
    current_therapist != nil
  end

  #When a therapist excepts a connection request, the updated_at record will be updated with the current time, therefore the connection is considered "accepted" when updated_at > created_at
  def connection_accepted
    if current_therapist
      patient_id = params[:patient_id]
      therapist_id = session[:therapist_id]
    elsif current_patient
      patient_id = session[:patient_id]
      therapist_id = params[:patient_id]
    else
      # Not logged in
      return false
    end
    connection = PatientTherapistRelationship.where(patient_id: patient_id, therapist_id: therapist_id) 
    if connection == []
      # no relationship
      return false
    end
    connection.updated_at > connection.created_at
  end

  helper_method :current_patient, 
                :current_therapist, 
                :patient_logged_in?, 
                :therapist_logged_in?
end
