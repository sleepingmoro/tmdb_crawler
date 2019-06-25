class AddTmdbIdToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :tmdb_id, :integer
  end
end
