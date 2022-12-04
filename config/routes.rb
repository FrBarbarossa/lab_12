Rails.application.routes.draw do
  root "palindromes#index"
  # get "palindromes", to: "palindromes#index"
  get "/result", to: "palindromes#result" 
  get "/show", to: "palindromes#show" 
  get "/register", to: "auth#register"
  get "/login", to: "auth#login"
  get "/logout", to: "auth#logout"
  get "/showuser", to: "auth#showuser"
  post "/register", to: "auth#register"
  post "/login", to: "auth#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end