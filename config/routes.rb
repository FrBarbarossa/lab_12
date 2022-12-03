Rails.application.routes.draw do
  root "palindromes#index"
  # get "palindromes", to: "palindromes#index"
  get "/result", to: "palindromes#result" 
  get "/show", to: "palindromes#show" 
  get "/register", to: "auth#register"
  get "/login", to: "auth#login"
  get "/logout", to: "auth#logout"
  post "/register", to: "auth#reguser"
  post "/login", to: "auth#loguser"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end