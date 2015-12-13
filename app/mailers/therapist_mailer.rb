class TherapistMailer < ApplicationMailer
  def verify(therapist)
    @therapist = therapist
    @admin = Admin.first
    mail_to @admin.email, subject: "[Secular Therapy Project] Therapist Application"
  end

  def confirm(therapist)
    @therapist = therapist
    mail_to @therapist.email, subject: "[Secular Therapy Project] Application Approved"
  end

  def reset_password(therapist)
    mail_to @therapist.email, subject: "[Secular Therapy Project] Reset Password"
  end
end
