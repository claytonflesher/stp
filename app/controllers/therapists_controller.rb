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

  def show
    @therapist = Therapist.find(session[:therapist_id])
  end

  def update
  end

  def edit
    @therapist = Therapist.find(session[:therapist_id])
  end

  private

  def therapist_params
    params.require(:therapist).permit(:username, :password, :password_confirmation, :first_name, :last_name, :phone, :email, :address, :city, :state, :country, :zipcode, :practice, :years_experience, :qualifications, :website, :gender, :religion, :previous_religion, :licenses, :main_license, :distance_counseling, :languages, :purpose, :public_description, :secular_evidence)
  end
end
