class PendingDashboard
  def initialize(admin)
    @admin = admin
  end

  def pending_therapists
    @pending_therapists ||= Therapist.pending
  end

  def admins
    @admins ||= Therapist.find_by(admin: true)
  end

  private

  attr_reader :admin
end
