class PatientMailer < ApplicationMailer
  def verify(patient)
    @patient = patient
    mail to: @patient.email, subject: "[Secular Therapy Project] Verify Email"
  end

  def reset_password(patient)
    @patient = patient
    mail to: @patient.email, subject: "[Secular Therapy Project] Reset Password"
  end
end
