class MessagesController < ApplicationController
  before_filter :ensure_is_your_message, except: [:index, :destroy]
  before_filter :ensure_super_admin, only: [:index, :destroy]

  def index
    @message = Message.all
  end

  def create
    @message = Message.create!(message_params)
    conversation = Conversation.find(message_params[:conversation_id])
    if @message.id
      redirect_to conversation_path(
        conversation_id: message_params[:conversation_id],
        patient_id: conversation.patient_therapist_relationship.patient_id, 
        therapist_id: conversation.patient_therapist_relationship.therapist_id
      )
    else
      render :new
    end
  end

  def show
    @message = Message.find(params[:message_id])
  end

  def edit
    @message = Message.find(params[:message_id])
  end

  def update
    if @message.update(message_params)
      flash.notice = "Message successfully edited"
      render :edit
    end
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
