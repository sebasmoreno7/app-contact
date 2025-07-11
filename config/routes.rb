Rails.application.routes.draw do
  # Defines the root path route ("/")
  root to: 'contacts#index'
  resources :contacts do
    get 'export_to_pdf', on: :collection, defaults: { format: 'pdf' }
  end
  
  end
