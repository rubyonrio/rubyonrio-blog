Enki::Application.routes.draw do

  namespace 'admin' do
    resources :posts, :pages do
      post 'preview', :on => :collection
    end
    resources :comments
    resources :members
    resources :undo_items do
      post 'undo', :on => :member
    end

    match 'health(/:action)' => 'health', :action => 'index', :as => :health

    root :to => 'dashboard#show'
  end

  resources :members, :only => [:index, :show], :path => :participantes
  resources :archives, :only => [:index]
  resources :pages, :only => [:show]

  match '/auth/twitter/callback', :to => 'twitter_auth#create'
  match "/signout" => "twitter_auth#destroy", :as => :signout

  match '/membro/:username' => 'members#show', :as => :member

  constraints :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ do
    post ':year/:month/:day/:slug/comments' => 'comments#index'
    get ':year/:month/:day/:slug/comments/new' => 'comments#new'
    get ':year/:month/:day/:slug' => 'posts#show', :as => :post
  end

  scope :to => 'posts#index' do
    get 'posts.:format', :as => :formatted_posts
    get '(:tag)', :as => :posts
  end

  root :to => 'posts#index'

  match '/past/:year/:month/:day/:old_slug' => "posts#old_slug", :old_slug => /.*/
end
