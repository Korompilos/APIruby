class CreateActivityLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_logs do |t|
      t.integer :user_id
      t.string :action
      t.string :path

      t.timestamps
    end
  end
end
