Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :morphs, only: [:index] do
        collection do
          post 'calculate'
        end
      end
    end
  end
end
