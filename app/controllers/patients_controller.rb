class PatientsController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:update, :edit, :new_message, :send_new_message, :show_conversation, :reply_to_message]
  before_filter :ensure_patient_not_signed_in, except: [:show, :update, :edit, :new_message, :send_new_message, :show_conversation, :reply_to_message]
  before_filter :ensure_should_see_profile, only: [:show]

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.create(patient_params)
    if @patient.id
      redirect_to patient_verify_path(patient_id: @patient.id)
    else
      render :new
    end
  end

  def show
    @patient = Patient.find(params[:patient_id])
    if patient_logged_in?
      @search ||= TherapistSearch.new(current_patient)
      @results = @search.find
    end
  end

  def update
    if @patient.update(patient_params)
      flash.notice = "Profile successfully update"
      redirect_to patient_dashboard_path 
    else
      render :edit 
    end
  end

  def edit
    @patient = Patient.find(session[:patient_id])
  end
  
  #####################
  # MESSAGING ACTIONS #
  #####################

  def show_conversation
    @patient = Patient.find(session[:patient_id])
    @message = @patient.messages.where(sent_messageable_id: params[:therapist_id]).first
    unless @message
      redirect_to patient_new_message_path(params[:therapist_id])
    end
    @conversation = @message.conversation
  end
  
  # GET
  #
  def new_message
    @patient = Patient.find(session[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @topic = @patient.username.to_s + @therapist.username.to_s
  end

  # POST
  def send_new_message
    @patient = Patient.find(session[:patient_id])
    # I'm pretty sure a therapist object is sent with the params, and I hope I can grab it this way
    @therapist = params[:therapist]
    if @patient.send_message(message_params[:therapist], message_params[:topic], message_params[:body])
      redirect_to show_conversation_path(@therapist.id)
    else
      render :new_message
    end
  end

  # POST
  def reply_to_message
    @patient = Patient.find(session[:patient_id])
    @therapist = params[:therapist]
    if @patient.reply_to(message_params)
      redirect_to show_conversation_path(@therapist.id)
    else
      render :show_conversation # Need error messages
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:username, :password, :password_confirmation, :name, :phone, :email, :zipcode, :gender, :former_religion, :description)
  end

  def message_params
    params.require(:acts_as_messageable).permit(:therapist, :patient, :topic, :body)
  end
end

