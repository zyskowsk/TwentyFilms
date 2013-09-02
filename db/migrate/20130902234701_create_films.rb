class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title, :null => false
      t.integer :release_year, :null => false
      t.string :director, :null => false

      t.timestamps
    end
  end
end
