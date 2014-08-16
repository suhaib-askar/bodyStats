Rails.application.routes.draw do

  
  #get '/profile' => 'users#profile', as: 'profile'

  # devise_for :users, path: '', path_names: { 
  #               sign_in: 'login', sign_out: 'logout', sign_up: 'join'
  #             }
  
  

  devise_for :users, skip: [:sessions, :passwords, :registrations]
  scope '(:locale)' do
  #scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    root 'static_pages#home'
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
      resources :track_items, only: [ :index, :create, :destroy, :update ], on: :member
      collection do
        get 'all' => 'projects#index', as: ''
        post 'all' => 'projects#create'
      end
      
    end
  end

  post 'set_locale' => 'sessions#set_locale', as: 'set_locale'
  #root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root
  #get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302), constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false

  # devise_for :users, skip: [:sessions, :passwords]
  # as :user do
  #   get 'sign_in' => 'devise/sessions#new', :as => :new_user_session
  #   post 'sign_in' => 'devise/sessions#create', :as => :user_session
  #   delete 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
    
  #   post 'password' => 'devise/passwords#create', :as => :user_password
  #   get 'forgot_password' => 'devise/passwords#new', :as => :new_user_password
  #   get 'edit_password' => 'devise/passwords#edit', :as => :edit_user_password

  # end
  
  
  # get 'microposts/create'

  # get 'microposts/destroy'

  
  # resources :sessions, only: [ :new, :create, :destroy ]
  
  # resources :users do
  #   member do
  #     get :following, :followers
  #   end
  # end
  # resources :relationships, only: [:create, :destroy]
  # resources :microposts, only: [ :create, :destroy ]

  # get '/contact' => 'static_pages#contact', as: :contact
  # get '/help' => 'static_pages#help', as: :help
  # get '/about' => 'static_pages#about', as: :about
  # get '/signup' => 'users#new', as: :signup
  # get '/signin' => 'sessions#new', as: :signin
  # delete '/signout' => 'sessions#destroy', as: :signout

  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
