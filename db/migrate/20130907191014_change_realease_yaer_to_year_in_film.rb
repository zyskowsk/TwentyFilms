class ChangeRealeaseYaerToYearInFilm < ActiveRecord::Migration
  def change
    rename_column :films, :release_year, :year
  end
end
