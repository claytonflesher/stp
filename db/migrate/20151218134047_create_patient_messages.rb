class CreatePatientMessages < ActiveRecord::Migration
  def change
    create_table :patient_messages do |t|

      t.timestamps null: false
    end
  end
end
