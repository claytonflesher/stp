class AdminsController < ApplicationController
  before_filter :ensure_admin

  def show
    @admin = Therapist.find(session[:therapist_id])
  end
end
