object @current_user
attributes :id, :name, :username, :profile
child(:films) do
  attributes :id, :title, :release_year, :director
end