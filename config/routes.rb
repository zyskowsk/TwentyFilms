TwentyFilms::Application.routes.draw do
  root :to => 'root#root'
  resources :users, :only => [:create, :update, :destroy]
  resource :session, :only => [:create, :destroy]
end
