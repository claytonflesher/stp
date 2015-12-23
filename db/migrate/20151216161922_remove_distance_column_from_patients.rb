class RemoveDistanceColumnFromPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :distance
  end
end
