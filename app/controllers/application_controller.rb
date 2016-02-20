class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_patient_signed_in
    unless current_super_admin
      unless current_patient
        session[:return_to] = request.url
        redirect_to patient_signin_path
      end
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
      redirect_to patient_dashboard_path(current_patient.id)
    end
  end

  def ensure_therapist_not_signed_in
    if current_therapist
      redirect_to therapist_dashboard_path(current_therapist.id)
    end
  end

  def ensure_admin
    unless current_admin
      session[:return_to] = request.url
      redirect_to therapist_signin_path
    end
  end

  def ensure_super_admin
    unless current_super_admin
      session[:return_to] = request.url
      redirect_to therapist_signin_path
    end
  end

  def ensure_relationship_exists
    unless patient_therapist_relationship_exists
      session[:return_to] = request.url
      if current_patient
        redirect_to patient_dashboard_path(current_patient.id)
      elsif current_therapist
        redirect_to therapist_dashboard_path(current_patient.id)
      else
        # Not logged in
        redirect_to home_path
      end
    end
  end

  def ensure_connection_accepted
    unless current_super_admin
      unless connection_accepted
        session[:return_to] = request.url
        if current_patient
          redirect_to patient_dashboard_path(current_patient.id)
        elsif current_therapist
          redirect_to therapist_dashboard_path(current_therapist.id)
        else
          # Not logged in
          redirect_to home_path
        end
      end
    end
  end

  def ensure_should_see_profile
    unless current_super_admin
      if patient_logged_in?
        unless current_patient.id.to_i == params[:patient_id].to_i
          # Patients should not view other patient's profiles
          session[:return_to] = request.url
          redirect_to patient_dashboard_path(current_patient.id)
        end
      end

      if therapist_logged_in?
        unless patient_therapist_relationship_exists
          # There is no relationship, so this therapist should not be viewing this patient's profile
          session[:return_to] = request.url
          redirect_to therapist_dashboard_path(current_therapist.id)
        end
      end
    end
  end

  def ensure_only_two_per_month
    @patient = current_patient
    @num_requests = PatientTherapistRelationship.where('created_at > ? and patient_id = ?', 30.days.ago, @patient.id).count
    Rails.logger.debug("@num_requests = #{@num_requests}")
    
    if @num_requests >= 2
      redirect_to exceeded_requests_path
    end
  end

  def ensure_first_request
    @patient = current_patient
    # This may not be the right way to find the therapist id....
    @therapist = Therapist.find(params[:therapist_id])
    unless PatientTherapistRelationship.where('patient_id = ? and therapist_id = ?', @patient.id, @therapist.id) == []
      flash.notice = "You have already submitted a connection request to this therapist"
      redirect_to therapist_dashboard_path(@therapist.id)
    end
  end
  
  def ensure_application_accepted
    @therapist = Therapist.find(params[:therapist_id])
    unless current_admin
      if @therapist.application_status == "denied" || @therapist.application_status == "pending"
        if current_therapist
          unless current_therapist.id == @therapist.id
            redirect_to therapist_dashboard_path(current_therapist.id)
          end
        elsif current_patient
          redirect_to patient_dashboard_path(current_patient.id)
        else
          redirect_to patient_signin_path
        end
      end
    end
  end

  def ensure_should_see_conversation
    unless current_super_admin
      @message = ActsAsMessageable::Message.find(params[:message_id])
      if current_patient
        @patient_id = current_patient.id.to_i
        if @message == nil
          redirect_to patient_inbox_path(@patient_id)
        elsif @message.sent_messageable_type == "Therapist"
          @therapist_id = @message.sent_messageable_id.to_i
          unless @patient_id == @message.received_messageable_id.to_i
            redirect_to patient_dashboard_path(@patient_id)
          end
        elsif @message.sent_messageable_type == "Patient"
          @therapist_id = @message.received_messageable_id.to_i
          unless @patient_id == @message.sent_messageable_id.to_i
            redirect_to patient_dashboard_path(@patient_id)
          end
        end
      elsif current_therapist
        @therapist_id = current_therapist.id.to_i
        if @message == nil
          redirect_to therapist_inbox_path(@therapist_id)
        elsif @message.sent_messageable_type == "Therapist"
          @patient_id = @message.received_messageable_id.to_i
          unless @therapist_id == @message.sent_messageable_id.to_i
            redirect_to therapist_dashboard_path(@therapist_id)
          end
        elsif @message.sent_messageable_type == "Patient"
          @patient_id = @message.sent_messageable_id.to_i
          unless @therapist_id == @message.received_messageable_id.to_i
            redirect_to therapist_dashboard_path(@therapist_id)
          end
        end
      else
        #not logged in
        redirect_to patient_signin_path
      end

      # If we've made it this far, we know that that someone is signed in, 
      # and their user id matches the appropriate user id in the message.  
      # Now we have to see if they have an active relationship
      @relationship = PatientTherapistRelationship.where(patient_id: @patient_id, therapist_id: @therapist_id).first

      if @relationship == nil
        redirect_to home_path
      end

      unless @relationship.status == "accept"
        redirect_to home_path
      end
    end
  end

  def ensure_should_see_patient_inbox
    unless current_super_admin
      if current_patient
        Rails.logger.debug("*~*~*~*~**~current_patient*~*~*~*~*~*~*~*~*")
        unless current_patient.id.to_i == params[:patient_id].to_i
          redirect_to patient_dashboard_path(current_patient.id)
        end
      else
        #not logged in
        Rails.logger.debug("*~*~*~*~*~*IT THINKS I'M NOT LOGGED IN!!!!*~*~*~*~*~*~*")
        redirect_to patient_signin_path
      end
    end
  end

  def ensure_should_see_therapist_inbox
    unless current_super_admin
      if current_therapist
        unless current_therapist.id.to_i == params[:therapist_id].to_i
          redirect_to therapist_dashboard_path(current_therapist.id)
        end
      else
        #not logged in
        redirect_to patient_signin_path
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

  def current_admin
    if current_therapist
      Therapist.find(session[:therapist_id]).admin?
    end
  end

  def current_super_admin
    if current_therapist
      Therapist.find(session[:therapist_id]).super_admin?
    end
  end

  def patient_therapist_relationship_exists
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
    PatientTherapistRelationship.where(patient_id: patient_id, therapist_id: therapist_id) != [] 
  end

  def connection_request_pending?
    unless patient_therapist_relationship_exists
      return false
    end

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
    
    @relationship = PatientTherapistRelationship.where(patient_id: patient_id, therapist_id: therapist_id).first
    @relationship.status == "pending"
  end

  def patient_logged_in?
    current_patient != nil
  end

  def therapist_logged_in?
    current_therapist != nil
  end

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
    @connection = PatientTherapistRelationship.where(patient_id: patient_id, therapist_id: therapist_id).first
    if @connection == nil
      # no relationship
      return false
    end

    @connection.status == "accept"
  end

  def find_first_message patient_id, therapist_id
    #Finds the first message between a patient and the therapist that seeds the conversation

    @patient = Patient.find(patient_id)
    @therapist = Therapist.find(therapist_id)
    
    # Did the therapist send the first message?
    @message = @therapist.messages.where(sent_messageable_type: "Therapist", 
                                         sent_messageable_id: therapist_id, 
                                         received_messageable_id: patient_id)
    if @message != []
      return @message.first
    end

    # No message was found, see if the patient has sent a message
    @message = @therapist.messages.where(sent_messageable_type: "Patient",
                                         sent_messageable_id: patient_id,
                                         received_messageable_id: therapist_id)
    if @message != []
     return @message.first
    end

    # Still haven't found a message, so no one has sent one yet. 
    # Return false will redirect user to the new_message path
    return false
  end

  def get_ids
   #For future refactoring 
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
                :current_admin,
                :current_super_admin,
                :patient_logged_in?, 
                :therapist_logged_in?,
                :find_first_message,
                :patient_therapist_relationship_exists,
                :connection_request_pending?,
                :connection_accepted,
                :voted_on?
end
