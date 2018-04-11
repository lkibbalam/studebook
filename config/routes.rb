Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :teams, shallow: true do
        resources :courses
        resources :users
      end
    end
  end
end
