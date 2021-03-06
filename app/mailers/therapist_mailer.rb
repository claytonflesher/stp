class TherapistMailer < ApplicationMailer
  def verify(therapist)
    @therapist = therapist
    @admins    = Therapist.where(admin: true)
    @admins.each do |admin|
      mail to: admin.email, subject: "[Secular Therapy Project] New Therapist Application"
    end
  end

  def confirm(therapist)
    @therapist = therapist
    mail to: @therapist.email, subject: "[Secular Therapy Project] Application Approved"
  end

  def reset_password(therapist)
    mail to: @therapist.email, subject: "[Secular Therapy Project] Reset Password"
  end
end
