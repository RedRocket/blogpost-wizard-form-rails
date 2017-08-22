Rails.application.routes.draw do
  root "wizards#step1"

  resources :users, except: [:new, :create] do
    collection do
      resource :wizard, path: "signup", only: [:create] do
        get :step1
        get :step2
        get :step3

        post :perform_step
      end
    end
  end
end
