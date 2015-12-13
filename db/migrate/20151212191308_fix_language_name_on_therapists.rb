class FixLanguageNameOnTherapists < ActiveRecord::Migration
  def change
    rename_column :therapists, :langauges, :languages
  end
end
