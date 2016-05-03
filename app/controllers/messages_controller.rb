class MessagesController < ApplicationController
  before_filter :ensure_is_your_message, except: [:index, :update, :destroy]
  before_filter :ensure_user_signed_in, only: [:index, :update]
  before_filter :ensure_super_admin, only: [:destroy]

  def index
    if current_patient
      @messages = Message.where(
        receiver_id: current_user.id, receiver_type: 'patient'
      )
    elsif current_therapist
      @messages = Message.where(
        receiver_id: current_user.id, receiver_type: 'therapist'
      )
    else
      @messages = nil
    end
  end

  def create
    @message = Message.create!(message_params)
    if message_params[:receiver_type] == 'patient'
      recipient = Patient.find(message_params[:receiver_id])
    else
      recipient = Therapist.find(message_params[:receiver_id])
    end
    MessageMailer.notify(recipient).deliver_now
    conversation = Conversation.find(message_params[:conversation_id])
    if @message.id
      redirect_to conversation_path(
        conversation_id: message_params[:conversation_id],
        patient_id: conversation.patient.id, 
        therapist_id: conversation.therapist.id
      )
    else
      render :new
    end
  end

  def show
    @message = Message.find(params[:message_id])
  end

  def update
    @message = Message.find_by(
      id: params[:message_id],
      receiver_id: current_user.id
    )
    @message.update!(opened: true)
    redirect_to conversation_path(
      conversation_id: @message.conversation_id,
      patient_id: @message.conversation.patient.id,
      therapist_id: @message.conversation.therapist.id
    )
  end

  def destroy
    @message = Message.find(params[:message_id])
    @message.destroy
    redirect_to super_admins_path
  end

  private

  def message_params
    params.require(:message).permit(:conversation_id, :topic, :body,
                                    :sender_type, :sender_id,
                                    :receiver_type, :receiver_id)
  end
end
