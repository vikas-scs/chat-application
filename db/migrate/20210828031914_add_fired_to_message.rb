class AddFiredToMessage < ActiveRecord::Migration[6.1]
  def change
  	add_column :messages, :conversation_id, :integer
  	add_column :messages, :user_id, :integer
  	add_column :users, :conversation_id, :integer
  end
end
