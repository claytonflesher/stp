class TherapistsController < ApplicationController
  before_filter :ensure_therapist_signed_in, only: [:show, :update, :edit]
  before_filter :ensure_therapist_not_signed_in, except: [:show, :update, :edit]

  def new
    @therapist = Therapist.new
  end


  def create
    @therapist = Therapist.create(therapist_params)
    if @therapist.id
      redirect_to therapist_verify_path(therapist_id: @therapist.id)
    else
      render :new
    end
  end

  # GET /therapist_dashboard
  def show
    @therapist = Therapist.find(params[:therapist_id])

    #For the send message/connection request button
    # if current_patient
      #Patient is signed in, see if there is a connection request
      # if PatientTherapistRelationship
        #There is a connection request, see if it has been accepted
  end

  def update
    @therapist = Therapist.find(session[:therapist_id])
    respond_to do |format|
      if @therapist.update(therapist_params)
        format.html { redirect_to therapist_dashboard_path, notice: 'Profile was successfully updated' }
        format.json { render :show, status: :ok, location: @therapist }
      else
        format.html { render :edit }
        format.json { render json: @therapist.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @therapist = Therapist.find(session[:therapist_id])
  end

  private

  def therapist_params
    params.require(:therapist).permit(:username, :password, :password_confirmation, :first_name, :last_name, :phone, :email, :address, :city, :state, :country, :zipcode, :practice, :years_experience, :qualifications, :website, :gender, :religion, :previous_religion, :licenses, :main_license, :distance_counseling, :languages, :purpose, :public_description, :secular_evidence).merge(geo_address: geo_address)
  end

  def geo_address
    if params[:therapist][:address] == ""
      ""
    elsif params[:therapist][:state] != "Not Applicable"
      [params[:therapist][:address],
       params[:therapist][:city],
       params[:therapist][:country],
       params[:therapist][:zipcode]
      ].join(", ")
    else
      [params[:therapist][:address],
       params[:therapist][:city],
       params[:therapist][:state],
       params[:therapist][:zipcode]
      ].join(", ")
    end
  end
end
