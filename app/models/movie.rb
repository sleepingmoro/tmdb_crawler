class Movie < ApplicationRecord
  has_many :credits
  has_many :people, :through => :credits
end
