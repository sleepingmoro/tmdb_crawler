class Movie < ApplicationRecord
  has_many :credits
  has_many :people, :through => :credits
  #
  # def self.get_or_create(id, title, desc)
  #   movie = Movie.where(tmdb_id: id).last
  #   movie ||= create_movie(id, title, desc)
  #   movie
  # end

  # def self.create_movie(id, title, desc)
  #   movie = Movie.new(tmdb_id: id, title: title, desc: desc)
  #   movie.save!
  #   movie
  # end
end
