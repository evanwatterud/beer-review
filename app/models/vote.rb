class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :value, presence: true, inclusion: { in: [1, -1] }
  validates :user_id, presence: true, numericality: true
  validates :review_id, presence: true, numericality: true
  validates :review_id, uniqueness: { :scope => :user_id }
end
