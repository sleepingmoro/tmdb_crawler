class Credit < ApplicationRecord
  belongs_to :movie
  belongs_to :tv
  belongs_to :person
end
