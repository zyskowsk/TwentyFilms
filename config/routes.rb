TwentyFilms::Application.routes.draw do
  root :to => 'root#root'
  
  get '/films/search' => 'films#search'
  delete '/followings' => 'followings#destroy'
  put '/films' => 'films#update'

  resources :users, :only => [:create, :update, :destroy, :show] 
  resources :films, :only => [:create, :destroy, :show]
  resource :session, :only => [:create, :destroy]
  resources :followings, :only => [:create]

end
