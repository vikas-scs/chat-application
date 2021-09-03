class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.integer :friend_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
