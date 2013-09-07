class AddApiFeildsToFilms < ActiveRecord::Migration
  def change
    add_column :films, :runtime, :string
    add_column :films, :genre, :string
    add_column :films, :writer, :string
    add_column :films, :actors, :string
    add_column :films, :plot, :string
    add_column :films, :poster, :string
    add_column :films, :trailer, :string
    add_column :films, :imdbid, :string
  end
end
