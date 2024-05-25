Rails.application.routes.draw do
  resources :emprunts
  resources :materiels
  resources :documents
  resources :auteurs
  resources :adherents

  get 'home/index'
  root 'home#index'

  resources :auteurs do
    resources :documents, only: [:index]
  end

  resources :emprunts do
    resources :documents
  end

  get 'inscription' => 'users#new'

  post "inscription" => 'users#create'

  delete "logout" => 'users#destroy'
  get "logout" => 'users#destroy'
  
  get "signin" => 'users#signin'
  post "signin" => 'users#login'

  patch '/signin', to: 'users#login'

  
  get 'charger_table_materiel', to: 'materiels#charger_table', as: 'materiel_import_csv'
  get 'charger_table_document', to: 'documents#charger_table', as: 'document_import_csv'
  get 'charger_table_auteur', to: 'auteurs#charger_table', as: 'auteur_import_csv'
  get 'charger_table_adherent', to: 'adherents#charger_table', as: 'adherent_import_csv'

  get "/searchAd" => "adherents#index", :as => :search_ad 
  get "/searchDoc" => "documents#index", :as => :search_doc 
  get "/searchAuth" => "auteurs#index", :as => :search_auth 


end
