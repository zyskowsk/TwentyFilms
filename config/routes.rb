TwentyFilms::Application.routes.draw do
  root :to => 'root#root'
  resources :users, :only => [:create, :update, :destroy] 
  resources :films, :only => [:create, :index]
  resource :session, :only => [:create, :destroy]
end
