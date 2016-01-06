class PatientMessagesController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:index, :reply_to_message, :new, :create]
  before_filter :ensure_connection_accepted, only: [:index, :new]
  # before_filter :ensure_connection_not_accepted, except: [:index, :reply_to_message]
  #
  # GET /patient_show_converation/:therapist_id
  def index
    @patient = Patient.find(session[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @message = find_first_message
    unless @message
      # They have not sent a message yet, go to form to send first message
      redirect_to patient_new_message_path(params[:therapist_id])
    end
    @patient_messages = @message.conversation
  end

  # POST /patient_reply_to_message
  def reply_to_message
    @patient = Patient.find(params[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @message = ActsAsMessageable::Message.find(params[:message_id])
    if @patient.reply_to(@message, @message.topic, params[:body]) 
      redirect_to patient_show_conversation_path(@therapist.id)
    else
      render :show_conversation # Need error messages
    end
  end

 # GET /patient_new_message/:therapist_id
  def new
    if find_first_message
      #There is already a conversation, should be at conversation view
      redirect_to patient_show_conversation_path(params[:therapist_id])
    end

    @message = ActsAsMessageable::Message.new

    @patient_id = session[:patient_id]
    @therapist_id = params[:therapist_id]
    @patient = Patient.find(@patient_id)
    @therapist = Therapist.find(@therapist_id)
    @topic = @patient.username.to_s + @therapist.username.to_s
  end

 # POST /messages
  def create
    @patient = Patient.find(params[:acts_as_messageable_message][:patient_id])
    @therapist = Therapist.find(params[:acts_as_messageable_message][:therapist_id])
    @patient.send_message(@therapist, params[:acts_as_messageable_message][:topic], params[:acts_as_messageable_message][:body])
    redirect_to patient_show_conversation_path(@therapist.id)
  end

end
