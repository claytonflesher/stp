class ConversationsController < ApplicationController
  before_filter :ensure_relationship_exists, except: [:index]
  before_filter :ensure_admin, only: [:index]

  def index
    @conversations = Conversation.all
  end

  def create
    @conversation = Conversation.create(conversation_params)
    if @conversation.id
      redirect_to conversation__path
    else
      render :new
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
