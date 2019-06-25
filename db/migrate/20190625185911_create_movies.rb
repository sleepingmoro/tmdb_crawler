class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    # TODO: not null 수정, tmdb_id unique 속성 추가
    create_table :movies do |t|
      t.string :title
      t.text :desc

      t.timestamps
    end
  end
end
