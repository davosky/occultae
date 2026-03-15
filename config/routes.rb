Rails.application.routes.draw do
  # Administrate
  namespace :admin do
      resources :supervisors

      root to: "supervisors#index"
    end

  # Devise
  devise_for :supervisors, skip: [ :registrations ]
  as :supervisor do
    get "supervisors/edit" => "devise/registrations#edit", :as => "edit_supervisor_registration"
    put "supervisors" => "devise/registrations#update", :as => "supervisor_registration"
  end

  root "home#index"

  get "home/index"
  get "home/credits"

  get "up" => "rails/health#show", as: :rails_health_check
end
