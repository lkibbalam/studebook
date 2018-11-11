# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  default_url_options host: 'http://localhost:8001'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  concern :commentable do
    member do
      get :comments
      post :create_comment
      patch :update_comment
      delete :destroy_comment
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'user/token' => 'user_token#create'
      get 'users/current' => 'users#current'

      post 'courses/create' => 'courses#create'
      get 'users/mentors' => 'users#mentors'
      post 'courses/:id/start_course' => 'courses_users#start_course'
      get 'courses/:id/current_user' => 'courses_users#show'
      get 'courses' => 'courses#all'
      get 'users' => 'users#all'
      get 'users/all' => 'users#index'

      post 'courses/:id/poster' => 'courses#update'
      get '/' => 'courses_users#index'

      patch 'users/current/change_password' => 'users#change_password'

      get 'padawans/:id' => 'courses_users#padawan_courses'
      get 'padawans/:id/tasks' => 'tasks_users#index'
      get 'padawans/:id/task' => 'tasks_users#show'
      patch 'padawans/:id/task' => 'tasks_users#update'
      patch 'tasks/:id/task_to_verify' => 'tasks_users#update'

      get 'notifications' => 'notifications#index'
      get 'lesson_user/:id' => 'lessons_users#show'
      patch 'notifications/:id/seen' => 'notifications#seen'
      patch 'lesson_user/:id/approve' => 'lessons_users#update'
      resources :teams, shallow: true do
        resources :courses, concerns: %i[commentable] do
          resources :lessons_users, concerns: %i[commentable], shallow: true
          resources :lessons, concerns: %i[commentable] do
            resources :tasks
            patch :done
          end
        end
        resources :users
        resources :comments, concerns: %i[commentable], shallow: true
      end
    end
  end
end
