class SessionsController < ApplicationController

  def new
  end

  def create
    patient = Patient.find_by(username: params[:session][:username].downcase)
    if patient && patient.authenticate(params[:session][:password])
      log_in patient
      redirect_to patient
    else
      # Leaving out flash for now per Clayton
      # flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end