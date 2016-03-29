class MessagesController < ApplicationController
  before_filter :ensure_relationship_exists, except: [:index, :destroy]
  before_filter :ensure_super_admin, only: [:index, :destroy]

  def index
    @message = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    if @message.id
      redirect_to conversation_path(conversation_id: message_params[:conversation_id])
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
    @message = Message.find(params[:id])
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
