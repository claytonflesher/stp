class TherapistMessagesController < ApplicationController
  before_filter :ensure_therapist_signed_in, only: [:index, :reply_to_message, :new, :create]
  #
  # GET /therapist_show_converation/:therapist_id
  def index
    @therapist = Therapist.find(params[:therapist_id])
    @patient = Patient.find(params[:patient_id])
    @message = find_first_message(@patient.id, @therapist.id)
    unless @message
      # They have not sent a message yet, go to form to send first message
      redirect_to therapist_new_message_path(params[:patient_id])
    end
    @therapist_messages = @message.conversation
    #If they're opening a conversation, mark the messages as read
    @therapist_messages.each do |m|
      m.update(opened: true)
    end
  end

  # POST /therapist_reply_to_message
  def reply_to_message
    @patient = Patient.find(params[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @message = ActsAsMessageable::Message.find(params[:message_id])
    if @therapist.reply_to(@message, @message.topic, params[:body]) 
      redirect_to therapist_show_conversation_path(@patient.id, @therapist.id)
    else
      render :show_conversation # Need error messages
    end
  end

 # GET /therapist_new_message/:patient_id
  def new
    @therapist_id = session[:therapist_id]
    @patient_id = params[:patient_id]

    if find_first_message(@patient_id, @therapist_id)
      #Conversation already exists, should be in conversation view
      redirect_to therapist_show_conversation_path(params[:patient_id])
    end
    @message = ActsAsMessageable::Message.new

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

  def inbox
    @therapist_id = session[:therapist_id]
    @therapist = Therapist.find(@therapist_id)
    @relationships = PatientTherapistRelationship.where(therapist_id: @therapist_id)
    @messages = Array.new

    @relationships.each do |r|
      message = Hash.new
      therapist = Therapist.find(r.therapist_id)
      patient = Patient.find(r.patient_id)
      
      message[:patient_id] = r.patient_id

      first_message = find_first_message(r.patient_id, r.therapist_id)

      if first_message == []
        #No message has been sent yet
        message[:body] = "Click to send a message"
        message[:opened] = true
        break
      end
      if r.created_at == r.updated_at
        message[:body] = "Connection request pending"
        message[:opened] = true
        break
      end

      conversation = first_message.conversation
      newest_message = conversation.first
      message[:body] = newest_message.body
      message[:opened] = newest_message.opened

      if newest_message.sent_messageable_type == "Therapist"
        #To be implemented later
        #message[:avatar] = therapist.avatar
        message[:name] = therapist.username
      else
        #message[:avatar] = patient.avatar
        message[:name] = patient.username
      end
      
      @messages.append(message)
    end

  end

end
