class AddProfileBooleansToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :adolescents,             :boolean
    add_column :therapists, :adults,                  :boolean
    add_column :therapists, :children,                :boolean
    add_column :therapists, :coping_with_change,      :boolean
    add_column :therapists, :depression,              :boolean
    add_column :therapists, :existential,             :boolean
    add_column :therapists, :general_anxiety,         :boolean
    add_column :therapists, :grief_loss,              :boolean
    add_column :therapists, :marriage_family,         :boolean
    add_column :therapists, :mood_disorders,          :boolean
    add_column :therapists, :ocd,                     :boolean
    add_column :therapists, :ptsd,                    :boolean
    add_column :therapists, :relationship_counseling, :boolean
    add_column :therapists, :self_improvement,        :boolean
    add_column :therapists, :sex_therapy,             :boolean
    add_column :therapists, :social_anxiety,          :boolean
    add_column :therapists, :stress_management,       :boolean
    add_column :therapists, :substance_abuse,         :boolean
    add_column :therapists, :trauma_recovery,         :boolean
  end
end
