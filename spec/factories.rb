FactoryGirl.define do 
  factory :user do
    name "foo bar"
    email "foo@bar.com"
    username "foobar"
    password "password"
    password_confirmation "password"
  end
end
