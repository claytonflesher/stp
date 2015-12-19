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

  def ensure_admin
    unless current_admin
      session[:return_to] = request.url
      redirect_to therapist_signin_path
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

  def current_admin
    if current_therapist
      Therapist.find(session[:therapist_id]).admin?
    end
  end

  def patient_logged_in?
    current_patient != nil
  end

  def therapist_logged_in?
    current_therapist != nil
  end

  helper_method :current_patient, 
                :current_therapist, 
                :patient_logged_in?, 
                :therapist_logged_in?
end
