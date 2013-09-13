TwentyFilms::Application.routes.draw do
  root :to => 'root#root'

  get 'auth/:provider/callback' => 'sessions#facebook_create'
  get 'auth/failure' => redirect('/')
  get 'signout' => 'sessions#destroy', as: 'signout'
  get 'bacon_number' => 'films#bacon_number' 
  get '/films/search' => 'films#search'
  delete '/followings' => 'followings#destroy'
  put '/films' => 'films#update'

  resources :users, :only => [:create, :update, :destroy, :show] 
  resources :films, :only => [:create, :destroy, :show]
  resource :session, :only => [:create, :destroy]
  resources :followings, :only => [:create]

end
