class AddOrdToFilmChoice < ActiveRecord::Migration
  def change
    add_column :film_choices, :ord, :integer
  end
end
