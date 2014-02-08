IssueTracker::Application.routes.draw do
  devise_for :users

  resources :tickets, except: [:destroy] do
    get 'history', on: :member
  end

  root to: 'pages#home'
end
