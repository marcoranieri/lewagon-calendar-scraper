class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :batches, dependent: :destroy
  has_many :days, through: :batches

  def username=(input)
    write_attribute(:username, input.to_s.capitalize)
  end

end
