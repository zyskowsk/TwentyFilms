collection @users
attributes :id, :name, :username, :profile, :email, :gravatar_id, :image
child(:films) do
  attributes :id, :title, :year, :director
end
child :followers => :followers do
  attributes :id, :name, :username, :profile, :email, :gravatar_id, :image
end
child :followed_users => :followed_users do
  attributes :id, :name, :username, :profile, :email, :gravatar_id, :image
end

