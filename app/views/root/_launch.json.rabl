collection @users
attributes :id, :name, :username, :profile, :email
child(:films) do
  attributes :id, :title, :year, :director
end
child :followers => :followers do
  attributes :id, :name, :username, :profile, :email
end
child :followed_users => :followed_users do
  attributes :id, :name, :username, :profile, :email
end

