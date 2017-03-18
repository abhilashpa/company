Rails.application.routes.draw do
  #User management
  devise_for :users, controllers: { sessions: 'users/sessions',registrations: 'users/registrations' }
  match 'user_root' => 'dashboard#index', as: :user_root,via: :all

  #User interaction
  get '/', to: 'landing#index'
  get '/dashboard', to: 'dashboard#index'

  #Company registration
  get '/company_registration', to: 'company_registration#index'
  post '/company_registration/save', to: 'company_registration#save'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
