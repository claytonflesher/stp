class MessagesController < ApplicationController
  #before_filter :ensure_patient_signed_in, only: [:index, :reply_to_message, :new, :create]
  before_filter :ensure_should_see_conversation, only: [:index]
  before_filter :ensure_should_see_patient_inbox, only: [:patient_inbox]
  before_filter :ensure_should_see_therapist_inbox, only: [:therapist_inbox]
  #
  # GET /show_conversation/:patient_id/:therapist_id
  def index
    @message = ActsAsMessageable::Message.find(params[:message_id])
    if @message.sent_messageable_type == "Patient"
      @patient = Patient.find(@message.sent_messageable_id.to_i)
      @therapist = Therapist.find(@message.received_messageable_id.to_i)
    else
      @patient = Patient.find(@message.received_messageable_id.to_i)
      @therapist = Therapist.find(@message.sent_messageable_id.to_i)
    end
    @messages = @message.conversation
    #If they're opening a conversation, mark the messages as read
    @messages.each do |m|
      m.update(opened: true)
    end
  end

  # POST /reply_to_message
  def reply_to_message
    @patient = Patient.find(params[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @message = ActsAsMessageable::Message.find(params[:message_id])
    if current_patient
      if @patient.reply_to(@message, @message.topic, params[:body]) 
        redirect_to show_conversation_path(@patient.id, @therapist.id)
      else
        render :show_conversation # Need error messages
      end
    elsif current_therapist
      if @therapist.reply_to(@message, @message.topic, params[:body]) 
        redirect_to show_conversation_path(@patient.id, @therapist.id)
      else
        render :show_conversation # Need error messages
      end
    end
  end

 # GET /new_message/:patient_id/:therapist_id
  def new
    @patient_id = params[:patient_id]
    @therapist_id = params[:therapist_id]
    
    if find_first_message(@patient_id, @therapist_id)
      #There is already a conversation, should be at conversation view
      redirect_to patient_show_conversation_path(params[:therapist_id])
    end

    @message = ActsAsMessageable::Message.new

    @patient = Patient.find(@patient_id)
    @therapist = Therapist.find(@therapist_id)
    @topic = @patient.username.to_s + @therapist.username.to_s
  end

 # POST /messages
  def create
    @patient = Patient.find(params[:acts_as_messageable_message][:patient_id])
    @therapist = Therapist.find(params[:acts_as_messageable_message][:therapist_id])
    if current_patient
      @patient.send_message(@therapist, params[:acts_as_messageable_message][:topic], params[:acts_as_messageable_message][:body])
    elsif current_therapist
      @therapist.send_message(@therapist, params[:acts_as_messageable_message][:topic], params[:acts_as_messageable_message][:body])
    end
    redirect_to show_conversation_path(@patient.id, @therapist.id)
  end

  def patient_inbox
    @patient_id = params[:patient_id]
    @patient = Patient.find(@patient_id)
=begin
    @relationships = PatientTherapistRelationship.where(patient_id: @patient_id)
    @messages = Array.new

    @relationships.each do |r|
      message = Hash.new
      therapist = Therapist.find(r.therapist_id)
      patient = Patient.find(r.patient_id)
      
      message[:therapist_id] = r.therapist_id

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
=end
    @messages = @patient.messages.where(sent_messageable_type: "Therapist")
  end

  def therapist_inbox
    @therapist_id = params[:therapist_id]
    @therapist = Therapist.find(@therapist_id)
=begin
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
=end
    @messages = @therapist.messages.where(sent_messageable_type: "Patient")
  end

end
