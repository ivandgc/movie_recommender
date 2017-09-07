class CreateWatchedMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :watched_movies do |t|
      t.boolean :rating
      t.belongs_to :user, foreign_key: true
      t.belongs_to :movie, foreign_key: true

      t.timestamps
    end
  end
end
