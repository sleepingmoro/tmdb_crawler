Rails.application.routes.draw do
  resources :movies, only: [:index, :show]
  resources :people, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/test/:id' => 'application#crawl'
end
