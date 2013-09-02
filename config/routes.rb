TwentyFilms::Application.routes.draw do
  root :to => 'root#welcome_root'
  resources :users, :only => [:create, :update, :destroy]
end
