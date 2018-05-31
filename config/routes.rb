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

      get 'users/:id/avatar' => 'users#get_avatar'
      post 'users/avatar' => 'users#update_avatar'
      get 'users/mentors' => 'users#mentors'
      post 'courses/:id/start_course' => 'courses#start_course'
      get 'courses' => 'courses#all'
      get 'users' => 'users#all'
      get '/' => 'courses_users#show'
      get 'padawans/:id' => 'courses_users#padawan'
      get 'padawans/:id/tasks' => 'tasks#index_padawan_tasks'
      get 'padawans/:id/task' => 'tasks#show_padawan_task'
      patch 'padawans/:id/task' => 'tasks#approve_or_change_task'
      patch 'tasks/:id/task_to_verify' => 'tasks#task_to_verify'
      get 'notifications' => 'notifications#index'
      get 'lesson_user/:id' => 'lessons_users#show'
      patch 'notifications/:id/seen' => 'notifications#seen'
      patch 'lesson_user/:id/approve' => 'lessons_users#approve_lesson'
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
