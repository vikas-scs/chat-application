class CreateConversationsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations_users do |t|
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
