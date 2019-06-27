class CreateTvEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_episodes do |t|
      t.string :name
      t.integer :season_id
      t.integer :tmdb_id

      t.timestamps
    end
  end
end
