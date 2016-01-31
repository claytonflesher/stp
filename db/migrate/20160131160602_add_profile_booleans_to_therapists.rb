class AddProfileBooleansToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :adolescents,             :boolean, default: false
    add_column :therapists, :adults,                  :boolean, default: false
    add_column :therapists, :children,                :boolean, default: false
    add_column :therapists, :coping_with_change,      :boolean, default: false
    add_column :therapists, :depression,              :boolean, default: false
    add_column :therapists, :existential,             :boolean, default: false
    add_column :therapists, :general_anxiety,         :boolean, default: false
    add_column :therapists, :grief_loss,              :boolean, default: false
    add_column :therapists, :marriage_family,         :boolean, default: false
    add_column :therapists, :mood_disorders,          :boolean, default: false
    add_column :therapists, :ocd,                     :boolean, default: false
    add_column :therapists, :ptsd,                    :boolean, default: false
    add_column :therapists, :relationship_counseling, :boolean, default: false
    add_column :therapists, :self_improvement,        :boolean, default: false
    add_column :therapists, :sex_therapy,             :boolean, default: false
    add_column :therapists, :social_anxiety,          :boolean, default: false
    add_column :therapists, :stress_management,       :boolean, default: false
    add_column :therapists, :substance_abuse,         :boolean, default: false
    add_column :therapists, :trauma_recovery,         :boolean, default: false
  end
end
