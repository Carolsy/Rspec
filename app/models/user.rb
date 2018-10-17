class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy

  validates :username, presence: true, length: { maximum: 20, minimum: 3 }
  validates :email, presence: true, length: { maximum: 20, minimum: 3 }

  before_save { self.email = email.downcase }

end
