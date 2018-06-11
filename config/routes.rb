Rails.application.routes.draw do
  resources :user, :account, :email

  resources :session do
    post 'login_attempt', on: :collection
  end

  get "signup", :to => "user#signup"
  get "login", :to => "session#login"
  get "logout", :to => "session#logout"
  get "profile", :to => "session#profile"
  get "/", :to => "email#index"
end
