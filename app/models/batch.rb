class Batch < ApplicationRecord
  belongs_to :user
  has_many :days

  validates :number, presence: true, uniqueness: true
end
