class ReanameColums < ActiveRecord::Migration[6.1]
  def change
  	rename_column :conversations, :user_id, :sender_id
  	rename_column :conversations, :friend_id, :recipient_id
  	add_index :conversations, [:recipient_id, :sender_id], unique: true
  end
end
