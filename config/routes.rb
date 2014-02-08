IssueTracker::Application.routes.draw do
  devise_for :users

  resources :tickets do
    get 'history', on: :member
  end

  root to: 'pages#home'
end
