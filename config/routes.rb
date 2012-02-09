JapanpageShare::Application.routes.draw do
  post "friendship/create"
  get "friendship/destroy"
  get "friendship/confirm"

  devise_for :users, :path => "", :path_names => {:sign_in => "login", :sign_up => "register", :sign_out => "logout"}
  root :to => "home#index"
  resources :people, :only => 'index'

  resources :user, :path => "", :controller => 'user' do
    resources :post, :only => [:destroy, :create]
    resources :friendship, :only => 'index'
    resources :photo, :only => [:index, :show, :create, :destroy]
  end

end
