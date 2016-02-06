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

  # Used to flag therapists the admin has not voted on yet
  # Helps admins quickly identify items that require their attention
  # This does not seem like an efficient way to do this,
  # since listing pending therapist loops through the admins votes for each therapist.
  # So if anyone has a better idea, or if we need to scrap this idea,
  # just let me know.
    
  private

  attr_reader :admin
end
