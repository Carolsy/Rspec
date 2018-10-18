class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  validates :username, presence: true, length: { maximum: 20, minimum: 3 }
  validates :email, presence: true, length: { maximum: 20, minimum: 3 }
end
