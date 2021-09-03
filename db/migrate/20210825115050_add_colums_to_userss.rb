class AddColumsToUserss < ActiveRecord::Migration[6.1]
  def change
  	rename_column :users, :lconfirmation_sent_at, :confirmation_sent_at
  end
end
