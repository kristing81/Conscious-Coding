Rails.application.routes.draw do

  devise_for :applicants, controllers: { omniauth_callbacks: "omniauth_callbacks"}
  devise_for :employers

  resources :employers
  resources :jobs
  resources :categories

  resources :charges, only: [:new, :create]
  
  get "/:categories/:category_id" => "category#show"#, as: :jobs_by_category
  #get "/:category_name" => "jobs#index", as: :jobs_by_category
  #get "opportunities/:category_name" => "jobs#index", as: :jobs_by_category
  root 'welcome#index'

  get '/about' => 'welcome#about'
end
