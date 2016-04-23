class VotesController < ApplicationController
  before_filter :ensure_admin

  def index
    @dashboard = PendingDashboard.new(current_therapist)
  end

  def create
    @vote = Vote.create!(vote_params)
    redirect_to votes_path
  end

  def delete
    Vote.where(voter_id: params[:voter_id],
               votee_id: params[:votee_id]
    ).first.destroy
    redirect_to votes_path
  end

  private

  def vote_params
    params.require(:vote).permit(:vote, :voter_id, :votee_id, :decision, :comment)
  end
end
