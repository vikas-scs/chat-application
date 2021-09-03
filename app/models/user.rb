class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
   validates :first_name, presence: :true, format: { with: /\A[a-zA-Z]+\z/}, uniqueness: true
   validates :mobile, format: { with: /\A[6-9]{1}\d{9}\z/ }, uniqueness: true, presence: :true
   validates :last_name, presence: :true, format: { with: /\A[a-zA-Z]+\z/}, uniqueness: true
   has_one_attached :profile
   has_many :friends
   has_many :friend_requests
   has_many :posts
   scope :online, ->{ where("last_seen_at > ?", 10.minutes.ago)}
   has_many :messages
   has_and_belongs_to_many :conversations
end
