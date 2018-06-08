# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: 'http://localhost:8001'
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

      post 'lessons/:id/poster' => 'lessons#update_poster'
      get 'lessons/:id/poster' => 'lessons#poster'
      post 'lessons/:id/video' => 'lessons#update_video'
      get 'lessons/:id/video' => 'lessons#video'
      post 'courses/:id/poster' => 'courses#update_poster'
      get 'courses/:id/poster' => 'courses#poster'
      post 'courses/create' => 'courses#create'
      get 'users/:id/avatar' => 'users#avatar'
      post 'users/avatar' => 'users#update_avatar'
      get 'users/mentors' => 'users#mentors'
      post 'courses/:id/start_course' => 'courses#start_course'
      get 'courses' => 'courses#all'
      get 'users' => 'users#all'
      get 'users/all' => 'users#index'
      get 'padawans/:id' => 'courses_users#padawan'

      get '/' => 'courses_users#index'

      get 'padawans/:id/tasks' => 'tasks_users#padawan_tasks'
      get 'padawans/:id/task' => 'tasks_users#padawan_task'
      patch 'padawans/:id/task' => 'tasks_users#approve_or_change_task'
      patch 'tasks/:id/task_to_verify' => 'tasks_users#task_to_verify'

      get 'notifications' => 'notifications#index'
      get 'lesson_user/:id' => 'lessons_users#show'
      patch 'notifications/:id/seen' => 'notifications#seen'
      patch 'lesson_user/:id/approve' => 'lessons_users#approve_lesson'
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
