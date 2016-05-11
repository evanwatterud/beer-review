class Review < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user
  has_many :votes

  validates :body, presence: true
  validates :user_id, presence: true, numericality: true
  validates :beer_id, presence: true, numericality: true
end
