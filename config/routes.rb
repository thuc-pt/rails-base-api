Rails.application.routes.draw do
  require "sidekiq/web"

  mount Sidekiq::Web => "/sidekiq"
  get "/docsv1", to: redirect("/docs/v1/index.html")
  namespace :api, format: :json do
    namespace :v1 do
      get "apiDocs", to:"api_docs#index" unless Rails.env.production?
    end
  end
end
