class CreateCustomMessages < ActiveRecord::Migration
  def change
    create_table :custom_messages do |t|

      t.timestamps null: false
    end
  end
end
