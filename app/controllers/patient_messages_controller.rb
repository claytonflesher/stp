class PatientMessagesController < ApplicationController
  before_filter :ensure_patient_signed_in, only: [:index, :reply_to_message, :new, :create]
  before_filter :ensure_connection_accepted, only: [:index, :reply_to_message, :new]
  # before_filter :ensure_connection_not_accepted, except: [:index, :reply_to_message]
  #
  # GET /messages
  # GET /messages.json
  def index
    @patient = Patient.find(session[:patient_id])
    @therapist = Therapist.find(params[:therapist_id])
    @message = patient_find_first_message 
    unless @message
      # They have not sent a message yet, go to form to send first message
      redirect_to patient_new_message_path(params[:therapist_id])
    end
    @patient_messages = @message.conversation
  end

  # POST
  def reply_to_message
    @patient = Patient.find(session[:patient_id])
    @therapist = params[:therapist]
    if @patient.reply_to(message_params)
      redirect_to patient_show_conversation_path(@therapist.id)
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

    @patient_id = session[:patient_id]
    @therapist_id = params[:therapist_id]
    @patient = Patient.find(@patient_id)
    @therapist = Therapist.find(@therapist_id)
    @topic = @patient.username.to_s + @therapist.username.to_s
  end

 # # GET /messages/1/edit
 # def edit
 # end

 # # POST /messages
 # # POST /messages.json
  def create
    @patient = Patient.find(params[:acts_as_messageable_message][:patient_id])
    @therapist = Therapist.find(params[:acts_as_messageable_message][:therapist_id])
    @patient.send_message(@therapist, params[:acts_as_messageable_message][:topic], params[:acts_as_messageable_message][:body])
    redirect_to patient_show_conversation_path(@therapist.id)
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
   # def message_params
   #   params.require[:acts_as_messageable_message].permit[:therapist_id, :patient_id, :topic, :body]
      #!!!!!!!!!!wrong number of arguments (0 for 1)
      #Parameters:
      #
      #{"utf8"=>"✓",
      # "authenticity_token"=>"FGFSS0SazqrVQoFanCkhUO/7c6bWP8tCC0fmjIXhdVNqgt1k87gVmqONlcbFU5orIMlC8oq/7eJGdac8uQevFQ==",
      #  "acts_as_messageable_message"=>{"therapist_id"=>"1",
      #   "patient_id"=>"2",
      #    "topic"=>"sivinstest",
      #     "body"=>"Hello!"},
      #      "commit"=>"Send"}!
   # end
end
