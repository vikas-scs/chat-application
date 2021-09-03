class AddFields < ActiveRecord::Migration[6.1]
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :mobile, :string
  	add_column :users, :status, :integer
  	add_column :admins, :role, :string
  end
end
