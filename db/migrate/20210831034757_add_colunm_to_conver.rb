class AddColunmToConver < ActiveRecord::Migration[6.1]
  def change
  	add_column :conversations, :friend_id, :integer
  end
end
