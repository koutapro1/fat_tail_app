Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :morphs, only: [:index]
    end
  end
end
