class User < ActiveRecord::Base
  has_many :reviews, -> { order('created_at DESC') }
  has_secure_password validations: false

  validates :username, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }, on: :create
end
