Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :jobs do
    member do
      post :collect
      post :discollect
    end

    collection do
      get :search
    end
    resources :resumes
  end

  root 'welcome#index'
  get 'about' => 'jobs#about'

  namespace :favorite do
    resources :jobs
  end



  namespace :admin do

    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end

  end

end
