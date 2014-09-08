Rails.application.routes.draw do
  
  get '(errors)/:status' => 'errors#show', constraints: { status: /\d{3}/ }, via: :all
  
  devise_for :users, skip: [:sessions, :passwords, :registrations]
  
  #scope '(:locale)' do
  
  #scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    root 'static_pages#home'

    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    
    #get '/:project_name' => 'projects#show', constraints: { id: /\d.+/ }, as: 'proj_id'
    
    
    #get '/:id' => 'projects#show', id: /login\/[^\/]+/
    get '/about' => 'static_pages#about', as: 'about'
    as :user do
      # session handling
      get     '/login'  => 'devise/sessions#new',     as: 'new_user_session'
      post    '/login'  => 'devise/sessions#create',  as: 'user_session'
      delete  '/logout' => 'devise/sessions#destroy', as: 'destroy_user_session'

      # joining
      get   '/join'    => 'devise/registrations#new',       as: 'new_user_registration'
      post  '/join'    => 'users/registrations#create',    as: 'user_registration'
      put   '/join'    => 'users/registrations#update',  as: ''
      # account deletion
      delete '/join' => 'devise/registrations#destroy', as: ''

      # password reset
      get   '/reset_password'        => 'devise/passwords#new',    as: 'new_user_password'
      post  '/reset_password'        => 'users/passwords#create', as: 'user_password'
      get   '/password/change'       => 'devise/passwords#edit',   as: 'edit_user_password'
      put   '/reset_password'        => 'devise/passwords#update', as: ''
      

      scope '/settings' do
        
        # confirmation
        # get   '/confirm'        => 'devise/confirmations#show',   as: 'person_confirmation'
        # post  '/confirm'        => 'devise/confirmations#create'
        # get   '/confirm/resend' => 'devise/confirmations#new',    as: 'new_user_confirmation'

        # settings & cancellation
        get '/cancel'  => 'devise/registrations#cancel',  as: 'cancel_user_registration'
        get '/profile' => 'users/registrations#edit',    as: 'edit_user_registration'
      end
    end

    resources :projects, path: '', except: [ :index, :create ] do
      resources :items, only: [ :index, :create, :destroy, :update ], on: :member do
        resources :track_items, only: [ :create, :update, :destroy ]
      end
      collection do
        get 'new' => 'projects#new', as: 'projects_path'
        post 'new' => 'projects#create'
      end
      post 'more_info' => 'project#more_info', as: 'more_info', on: :member
    end
  #end

  post 'set_locale' => 'sessions#set_locale', as: 'set_locale'
end
