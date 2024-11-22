class CreateRequestLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :request_logs do |t|
      t.string :controller
      t.string :action
      t.string :path
      t.integer :status
      t.integer :duration_ms
      t.string :visitor_hash
      t.references :user, null: true, foreign_key: true
      t.string :user_agent
      t.string :ip

      t.timestamps
    end
  end
end
