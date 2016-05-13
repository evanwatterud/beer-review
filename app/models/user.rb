class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_many :beers
  has_many :reviews
  has_many :votes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true, inclusion: { in: ['admin', 'member'] }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end

  def admin?
    role == 'admin'
  end
end
