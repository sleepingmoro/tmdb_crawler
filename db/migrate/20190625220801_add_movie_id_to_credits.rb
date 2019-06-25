class AddMovieIdToCredits < ActiveRecord::Migration[5.2]
  def change
    add_column :credits, :movie_id, :integer
  end
end
