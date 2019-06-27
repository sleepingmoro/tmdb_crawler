class Tv < ApplicationRecord
  has_many :credits
  has_many :people, :through => :credits
  has_many :tv_seasons
end
