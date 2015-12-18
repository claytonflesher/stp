class PatientMessagesController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:index, :reply_to_message, :new, :create]
  # before_filter :ensure_connection_accepted, only: [:index, :reply_to_message]
  # before_filter :ensure_connection_not_accepted, except: [:index, :reply_to_message]
  #
  # GET /messages
  # GET /messages.json
  def index
    @patient = Patient.find(session[:patient_id])
    @message = @patient.messages.where(sent_messageable_id: params[:therapist_id]).first
    unless @message
      redirect_to patient_new_message_path(params[:therapist_id])
    end
    @conversation = @message.conversation
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

  # GET /messages/1
  # GET /messages/1.json
 # def show
 # end

 # # GET /messages/new
  def new
    @message = ActsAsMessageable::Message.new

    @patient = Patient.find(session[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @topic = @patient.username.to_s + @therapist.username.to_s
  end

 # # GET /messages/1/edit
 # def edit
 # end

 # # POST /messages
 # # POST /messages.json
  def create
    @patient = Patient.find(session[:patient_id])
    @therapist = params[:therapist]
    if @patient.send_message(message_params[:therapist], message_params[:topic], message_params[:body])
      redirect_to show_conversation_path(@therapist.id)
    else
      render :new
    end
  end

 # # PATCH/PUT /messages/1
 # # PATCH/PUT /messages/1.json
 # def update
 #   respond_to do |format|
 #     if @message.update(message_params)
 #       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
 #       format.json { render :show, status: :ok, location: @message }
 #     else
 #       format.html { render :edit }
 #       format.json { render json: @message.errors, status: :unprocessable_entity }
 #     end
 #   end
 # end

 # # DELETE /messages/1
 # # DELETE /messages/1.json
 # def destroy
 #   @message.destroy
 #   respond_to do |format|
 #     format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
 #     format.json { head :no_content }
 #   end
 # end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_message
    #  @message = Message.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require[:message].permit(:therapist, :patient, :topic, :body)
    end
end
