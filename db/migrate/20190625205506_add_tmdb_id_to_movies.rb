class AddTmdbIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :tmdb_id, :integer
  end
end
