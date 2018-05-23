# frozen_string_literal: true

Rails.application.routes.draw do
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

      post 'courses/:id/start_course' => 'courses#start_course'
      get 'courses' => 'courses#all'
      get 'users' => 'users#all'
      get '/' => 'courses_users#show'
      get 'padawans/:id' => 'courses_users#padawan'
      get 'padawans/:id/tasks' => 'tasks#padawan_tasks'
      get 'notifications' => 'notifications#index'
      get 'lesson_user/:id' => 'lessons_users#show'
      patch 'notifications/:id/seen' => 'notifications#seen'
      patch 'tasks/:id/task_to_verify' => 'tasks#task_to_verify'
      patch 'tasks/:id/approve_task' => 'tasks#approve_task'
      patch 'lesson_user/:id/approve' => 'lessons_users#approve'
      resources :teams, shallow: true do
        resources :courses, concerns: %i[commentable] do
          resources :lessons_users, concerns: %i[commentable], shallow: true
          resources :lessons, concerns: %i[commentable] do
            patch :done
          end
        end
        resources :users
        resources :comments, concerns: %i[commentable], shallow: true
      end
    end
  end
end
