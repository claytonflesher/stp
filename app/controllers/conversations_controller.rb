class ConversationsController < ApplicationController
  before_filter :ensure_relationship_exists, except: [:index]
  before_filter :ensure_admin, only: [:index]

  def index
    @conversations = Conversation.all
  end

  def create
    @conversation = Conversation.create(
      patient_therapist_relationship_id: params[:patient_therapist_relationship_id]
    )
    if @conversation.id
      redirect_to conversation_path(
        conversation_id: @conversation.id,
        patient_id:   params[:patient_id],
        therapist_id: params[:therapist_id]
      )
    else
      redirect_to root_path
    end
  end

  def show
    @conversation = Conversation.find(params[:conversation_id])
  end

  def destroy
    @conversation = Conversation.find(conversation_id: conversation_id)
    if @conversation.id
      @conversation.delete!
    end
    redirect_to admin_path
  end
end
