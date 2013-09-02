class CreateFilmChoices < ActiveRecord::Migration
  def change
    create_table :film_choices do |t|
      t.integer :user_id, :null => false
      t.integer :film_id, :null => false

      t.timestamps
    end
    add_index :film_choices, :user_id
    add_index :film_choices, :film_id
  end
end
