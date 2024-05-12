Rails.application.routes.draw do
  resources :emprunts
  resources :materiels
  resources :documents
  resources :auteurs
  resources :adherents
  get 'home/index'
  root 'home#index'

  get 'inscription' => 'users#new'

  post "inscription" => 'users#create'

  delete "logout" => 'users#destroy'
  get "logout" => 'users#destroy'
  
  get "signin" => 'users#signin'
  post "signin" => 'users#login'

  patch '/signin', to: 'users#login'

  

  get "/searchAd" => "adherents#index", :as => :search_ad 
  get "/searchDoc" => "documents#index", :as => :search_doc 
  get "/searchAuth" => "auteurs#index", :as => :search_auth 

end
