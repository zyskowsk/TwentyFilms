TwentyFilms::Application.routes.draw do
  root :to => 'root#root'
  resources :users, :only => [:create, :update, :destroy, :show] 
  resources :films, :only => [:create, :index, :destroy, :show]
  resource :session, :only => [:create, :destroy]
  resources :followings, :only => [:create]

  delete '/followings' => 'followings#destroy'
  put '/films' => 'films#update'
end
