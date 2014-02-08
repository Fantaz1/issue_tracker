IssueTracker::Application.routes.draw do
  devise_for :users

  resources :tickets, except: [:destroy] do
    member do
      get 'history'
      put 'reply'  
    end
  end

  root to: 'pages#home'
end
