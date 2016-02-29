class TherapistsController < ApplicationController
  before_filter :ensure_therapist_signed_in, only: [:update, :edit]
  before_filter :ensure_therapist_not_signed_in, except: [:update, :edit, :show]
  before_filter :ensure_application_accepted, only: [:show]
  before_filter :ensure_admin, only: [:destroy]

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
    if current_patient
      @message = find_first_message(session[:patient_id], params[:therapist_id])
    end
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

  def destroy
    @therapist = Therapist.find(params[:id])
    @therapist.destroy

    redirect_to admins_path
  end

  private

  def therapist_params
    params.require(:therapist).permit(
      :username, 
      :password, 
      :password_confirmation, 
      :first_name, 
      :last_name, 
      :phone, 
      :email, 
      :address, 
      :city, 
      :state, 
      :country, 
      :zipcode, 
      :practice, 
      :years_experience, 
      :qualifications, 
      :website, 
      :gender, 
      :religion, 
      :previous_religion, 
      :licenses, 
      :main_license, 
      :distance_counseling, 
      :languages, 
      :purpose, 
      :public_description, 
      :secular_evidence,
      :adolescents,
      :adults,
      :children,
      :coping_with_change,
      :depression,
      :existential,
      :general_anxiety,
      :grief_loss,
      :marriage_family,
      :mood_disorders,
      :ocd,
      :ptsd,
      :relationship_counseling,
      :self_improvement,
      :sex_therapy,
      :social_anxiety,
      :stress_maagement,
      :substance_abuse,
      :trauma_recovery
    ).merge(geo_address: geo_address)
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
