TwentyFilms::Application.routes.draw do
  root :to => 'root#root'
  resources :users, :only => [:create, :update, :destroy] do
    resources :films, :only => [:create]
  end
  resource :session, :only => [:create, :destroy]
end
