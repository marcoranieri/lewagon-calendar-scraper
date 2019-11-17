class Day < ApplicationRecord
  belongs_to :batch, counter_cache: true # .size

  scope :get_working_days,     -> (user){where("? = ANY(colleagues)",user.username)}
  scope :get_not_working_days, -> (user){where.not("? = ANY(colleagues)",user.username)}
end
