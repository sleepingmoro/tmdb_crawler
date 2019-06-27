class TvSeason < ApplicationRecord
  belongs_to :tv
  has_many :tv_episodes
end
