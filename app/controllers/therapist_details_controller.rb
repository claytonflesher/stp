class TherapistDetailsController < ApplicationController
  before_filter :ensure_user_signed_in

  def show
    @therapist   = Therapist.find(params[:therapist_id])
    t = @therapist
    @specialties = []
    @specialties << 'Adults'                         if t.adults
    @specialties << 'Children'                       if t.children
    @specialties << 'Coping With Change'             if t.coping_with_change
    @specialties << 'Depression'                     if t.depression
    @specialties << 'Existential Issues'             if t.existential
    @specialties << 'General Anxiety'                if t.general_anxiety
    @specialties << 'Grief and Loss'                 if t.grief_loss
    @specialties << 'Marriage and Family Counseling' if t.marriage_family
    @specialties << 'Mood Disorders'                 if t.mood_disorders
    @specialties << 'Obsessive Compulsive Disorder'  if t.ocd
    @specialties << 'Post-tramautic Stress Disorder' if t.ptsd
    @specialties << 'Relationship Counseling'        if t.relationship_counseling
    @specialties << 'Self-Improvement'               if t.self_improvement
    @specialties << 'Sex Therapy'                    if t.sex_therapy
    @specialties << 'Social Anxiety'                 if t.social_anxiety
    @specialties << 'Stress Management'              if t.stress_management
    @specialties << 'Substance Abuse'                if t.substance_abuse
    @specialties << 'Trauma Recovery'                if t.trauma_recovery
  end
end
