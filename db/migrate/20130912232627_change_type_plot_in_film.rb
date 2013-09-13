class ChangeTypePlotInFilm < ActiveRecord::Migration
 change_column :films, :plot, :text
end
