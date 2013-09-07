object @users
attributes :id, :name, :username, :profile, :email
child(:films) do
  attributes :id, :title, :release_year, :director
end
