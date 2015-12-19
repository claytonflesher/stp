class TherapistMessagesController < ApplicationController
  before_filter :ensure_therapist_signed_in, only: [:index, :reply_to_message, :new, :create]
  # before_filter :ensure_connection_accepted, only: [:index, :new]
  # before_filter :ensure_connection_not_accepted, except: [:index, :reply_to_message]
  #
  # GET /therapist_show_converation/:therapist_id
  def index
    @therapist = Therapist.find(session[:therapist_id])
    @patient = Patient.find(params[:patient_id])
    @message = find_first_message
    unless @message
      # They have not sent a message yet, go to form to send first message
      redirect_to therapist_new_message_path(params[:patient_id])
    end
    @therapist_messages = @message.conversation
  end

  # POST /therapist_reply_to_message
  def reply_to_message
    @patient = Patient.find(params[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @message = ActsAsMessageable::Message.find(params[:message_id])
    if @therapist.reply_to(@message, @message.topic, params[:body]) 
      redirect_to therapist_show_conversation_path(@patient.id)
    else
      render :show_conversation # Need error messages
    end
  end

 # GET /therapist_new_message/:therapist_id
  def new
    @message = ActsAsMessageable::Message.new

    @therapist_id = session[:therapist_id]
    @patient_id = params[:patient_id]
    @patient = Patient.find(@patient_id)
    @therapist = Therapist.find(@therapist_id)
    @topic = @therapist.username.to_s + @therapist.username.to_s
  end

 # POST /messages
  def create
    @patient = Patient.find(params[:acts_as_messageable_message][:patient_id])
    @therapist = Therapist.find(params[:acts_as_messageable_message][:therapist_id])
    @therapist.send_message(@therapist, params[:acts_as_messageable_message][:topic], params[:acts_as_messageable_message][:body])
    redirect_to therapist_show_conversation_path(@patient.id)
  end

end
