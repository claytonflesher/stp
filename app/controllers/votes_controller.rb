class VotesController < ApplicationController
  before_filter :ensure_admin

  def index
    @dashboard = PendingDashboard.new(current_admin)
  end

  def create
    params.each_pair do |key, value|
      p "#{key} = #{value}"
    end
    @vote = Vote.find_or_initialize_by(
      voter_id: session[:therapist_id], 
      votee_id: params[:votee_id]
    )
    if @vote.update(
      decision: params[:decision],
      comment:  params[:comment]
    )
      flash[:notice] = "Vote successfuly saved."
      redirect_to therapist_dashboard_path(params[:votee_id])
    else
      flash.now[:error] = "Vote failed to save."
      render :index
    end
  end

  def delete
    params.each_pair do |key, value|
      p "#{key} = #{value}"
    end
    @vote = Vote.find_by(
      voter_id: session[:therapist_id],
      votee_id: params[:votee_id]
    )
    if @vote.destroy
      flash[:notice] = "Please cast your new vote"
      redirect_to therapist_dashboard_path(params[:votee_id])
    else
      flash.now[:error] = "Could not delete existing vote"
      render :index
    end
  end
end
