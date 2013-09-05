TwentyFilms::Application.routes.draw do
  root :to => 'root#root'
  resources :users, :only => [:create, :update, :destroy] 
  resources :films, :only => [:create, :index, :destroy]
  resource :session, :only => [:create, :destroy]

  put '/films' => 'films#update'
end
