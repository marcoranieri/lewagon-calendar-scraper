class Batch < ApplicationRecord
  belongs_to :user
  has_many :days, dependent: :destroy

  validates :number, presence: true, uniqueness: true

  scope :my_batches, -> (user) { where(user: user).order(number: :desc) }
end
