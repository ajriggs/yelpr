class Business < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  has_many :reviews

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }

  def latest_review
    reviews.first
  end

  def self.search_by_name(query)
    where("name ILIKE ?", "%#{query}%").order 'created_at DESC'
  end
end
