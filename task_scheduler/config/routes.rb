Rails.application.routes.draw do
  root to: redirect('/api/tasks')
  scope :api do
    resources :agents, only: [:create]
    resources :tasks
    post '/task-success' => 'tasks#success'
    post '/task-failure' => 'tasks#failure'
  end
end
