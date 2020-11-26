Rails.application.routes.draw do
  resources :appointments
  scope 'api' do  
    scope 'v1' do  
      # No need to register client application
      use_doorkeeper do  
        skip_controllers :applications, :authorized_applications
      end    
    end
  end  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users
      resources :teachers

      get '/cloudinary', to: 'cloudinary#index', as: 'get_upload_preset'
    end
  end    
end
