Rails.application.routes.draw do

  devise_for :applicants, controllers: { omniauth_callbacks: "omniauth_callbacks"}
  devise_for :employers

  resources :jobs, only: [:index, :new, :create]

  resources :categories do
    resources :jobs, except: [:index, :new, :create]
  end
  
  get "/:category_name" => "category#show", as: :jobs_by_category
  #get "/:category_name" => "jobs#index", as: :jobs_by_category
  #get "opportunities/:category_name" => "jobs#index", as: :jobs_by_category
  root 'welcome#index'

  get '/about' => 'welcome#about'
end
