Rails.application.routes.draw do
  #User management
  devise_for :users, controllers: { sessions: 'users/sessions',registrations: 'users/registrations' }
  devise_scope :user do
    get '/users', to: 'users/registrations#new'
  end
  match 'user_root' => 'dashboard#index', as: :user_root,via: :all

  #User interaction
  get '/', to: 'landing#index'
  get '/dashboard', to: 'dashboard#index'


  #Create opennings
  get '/create_opening', to: 'dashboard#create_opening'
  post '/save_opening', to: 'dashboard#save_opening'


  #Company registration
  get '/company_registration', to: 'company_registration#index'
  post '/company_registration/save', to: 'company_registration#save'

# Dashoboard API's
  get 'dashboard/departments'
  get 'dashboard/cities'
  get 'dashboard/search_college_drives'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
