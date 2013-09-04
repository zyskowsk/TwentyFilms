class ChangeFilmColumns < ActiveRecord::Migration
  def change
    rename_column :films
  end
end
