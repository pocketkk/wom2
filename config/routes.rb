Rails.application.routes.draw do
  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :workorders, only: [:create, :show, :update]
    end
  end
end
