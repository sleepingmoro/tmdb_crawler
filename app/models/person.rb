class Person < ApplicationRecord
  has_many :credits
  has_many :movies, :through => :credits

  # def self.get_or_create(id, name, birthday, gender)
  #   person = Person.where(tmdb_id: id).last
  #   person ||= create_person(id, name, birthday, gender)
  #   person
  # end
  #
  # def create_person(id, name, birthday, gender)
  #   person = Person.new(tmdb_id: id, name: name, birthday: birthday, gender: gender)
  #   person.save!
  #   person
  # end
end
