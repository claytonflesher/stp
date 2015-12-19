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
      therapist_id = params[:therapist_id]
    else
      # Not logged in
      return false
    end
    connection = PatientTherapistRelationship.where(patient_id: patient_id, therapist_id: therapist_id) 
    if connection == []
      # no relationship
      return false
    end
    #if the connection has been updated after it was created, that means it was accepted by the therapist
    connection.first.updated_at > connection.first.created_at
  end

  def find_first_message
    #Finds the first message between a patient and the therapist that seeds the conversation
    if current_therapist
      patient_id = params[:patient_id]
      therapist_id = session[:therapist_id]
    elsif current_patient
      patient_id = session[:patient_id]
      therapist_id = params[:therapist_id]
    else
      #Not logged in
      return false
    end

    @patient = Patient.find(patient_id)
    @therapist = Therapist.find(therapist_id)
    
    # Did the therapist send the first message?
    @message = @therapist.messages.where(sent_messageable_type: "Therapist", 
                                         sent_messageable_id: therapist_id, 
                                         received_messageable_id: patient_id)
    if @message != []
      return @message
    end

    # No message was found, see if the patient has sent a message
    @message = @therapist.messages.where(sent_messageable_type: "Patient",
                                         sent_messageable_id: patient_id,
                                         received_messageable_id: therapist_id)
    if @message != []
     return @message
    end

    # Still haven't found a message, so no one has sent one yet. 
    # Return false will redirect user to the new_message path
    return false
  end

  def therapist_find_first_message
    # Will probably have the exact same implementation, but look for therapist_id in the session and patient_id in the url params
  end

  def get_ids
   #For future refactoring 
  end

  helper_method :current_patient, 
                :current_therapist, 
                :patient_logged_in?, 
                :therapist_logged_in?,
                :find_first_message
end
