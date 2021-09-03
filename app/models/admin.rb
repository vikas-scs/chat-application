class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   serialize :read_privileges, Array
   serialize :write_privileges, Array
   serialize :create_privileges, Array
   serialize :delete_privileges, Array
   rails_admin do
    field :email
    field :role
    field :read_privileges
    field :write_privileges
    field :create_privileges
    field :delete_privileges
    end
end
