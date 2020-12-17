Rails.application.routes.draw do
  scope 'api' do  
    scope 'v1' do  
      use_doorkeeper do  
        skip_controllers :applications, :authorized_applications
      end    
    end
  end  

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get '/users/last', to: 'users#last', as: 'users_last'
      get '/users/myprofile', to: 'users#myprofile', as: 'users_myprofile'
      get '/cloudinary', to: 'cloudinary#index', as: 'get_upload_preset'
      get '/teachers/last', to: 'teachers#last', as: 'teachers_last'
      get '/teachers/:id/availability/:date', to: 'teachers#availability', as: 'teachers_availability'
      get '/teachers/:id/appointments', to: 'teachers#appointments', as: 'teachers_appointments'
      get '/appointments/last', to: 'appointments#last', as: 'appointments_last'

      resources :users
      resources :teachers
      resources :appointments
    end
  end    
end
