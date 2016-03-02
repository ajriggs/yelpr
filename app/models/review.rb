class Review < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  belongs_to :user
  belongs_to :business

  validates :body, presence: true, length: {minimum: 10}
  validates_uniqueness_of :user_id, scope: :business_id

  def business_name
    business.name
  end

  def username
    user.username
  end
end
