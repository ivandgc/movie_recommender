class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.string :poster_path
      t.string :overview
      t.string :release_date
      t.string :rating

      t.timestamps
    end
  end
end
