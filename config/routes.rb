Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users

  resources :competitions do
    resources :matches, except: [:new] do
      resources :team_score_sheets do
        post :score_amp, on: :member
        post :score_trap, on: :member
        post :score_speaker, on: :member
        post :score_amp_auto, on: :member
        post :score_speaker_auto, on: :member
        post :score_trap, on: :member
        post :park, on: :member
        post :leave, on: :member
        post :toggle_auto, on: :member
        post :toggle_teleop, on: :member
        post :scouting_complete, on: :member
      end
    end
  end

  resources :teams do
    resources :team_logs
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "competitions#index"
end
