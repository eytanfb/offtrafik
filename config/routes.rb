Offtrafik::Application.routes.draw do
scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  
  devise_for :users, controllers: { registrations: 'users' }
  
  devise_scope :user do
    get 'users/:id/postings' => 'users#postings', as: :user_postings
    get 'users/:id/past_postings' => 'users#past_postings', as: :user_past_postings
    get 'users/:id/past_responses' => 'posting_responses#past_responses', as: :user_past_responses
    match 'users/:id' => 'users#show', as: :user
    match 'users/:id/edit' => 'users#edit', as: :edit_user
  end
  
  root to: 'static_pages#welcome'
  
  # Matching static_pages
  match '/help', to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/why', to: 'static_pages#why'
  match '/terms_and_conditions', to: 'static_pages#terms_and_conditions'
  match '/admin', to: 'static_pages#admin'
  match '/welcome', to: 'static_pages#welcome'
  
  # Matching postings
  match '/find_posting', to: 'postings#find'
  match '/find_from_home', to: 'postings#find_from_home_page'
  match '/find_user', to: 'users#find'
  match '/share_posting', to: 'postings#share_posting'
  match '/all_postings', to: 'postings#all_postings'

  resources :postings, except: [:update, :index] do
    post 'respond', as: :respond
    get 'contact_posting_owner'
    get 'full', as: :full
    get 'preview', as: :preview
  end
  
  resources :frequent_postings, only: [:create]
  resources :comments, only: [:show, :new, :create]
  resources :posting_responses, only: [] do
    post 'accept'
    get 'reject'
    get 'happened'
    get 'not_happened'
    get 'enter_phone'
  end
end
end
