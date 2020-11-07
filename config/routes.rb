Rails.application.routes.draw do

  use_doorkeeper
  devise_for :users
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :teachers
    end
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
