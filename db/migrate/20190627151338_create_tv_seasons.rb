class CreateTvSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_seasons do |t|
      t.string :name
      t.integer :season_number
      t.integer :tmdb_id
      t.integer :tv_id

      t.timestamps
    end
  end
end
