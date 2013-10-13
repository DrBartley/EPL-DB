AAAAMILNE::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  

  scope :arsenal do
    get "/prematchjson(.:format)" => "fixtures#prematchjson"
    get "/prematchjson/:id(.:format)" => "fixtures#prematchjsonid"
  end


  resources :home_xis

  resources :fixtures
  get 'fixturesjson/:team' => 'fixtures#fixturesjson'
  get 'tablejson' => 'fixtures#tablejson'
  get 'formjson/:team' => 'fixtures#formjson'
  get 'megajson/:team' => 'fixtures#megajson'
  get 'topscorers/:team' => 'fixtures#topscorers'
  get 'liveposspie' => 'fixtures#liveposspie'

  get 'livepossjson' => 'fixtures#livepossjson'
  get 'liveshotjson' => 'fixtures#liveshotjson'
  get 'livetargetjson' => 'fixtures#livetargetjson'
  get 'livecornerjson' => 'fixtures#livecornerjson'
  get 'livefouljson' => 'fixtures#livefouljson'

  get "news/index"
  resources :articles
  put 'opta' => 'articles#opta'
  put 'populater' => 'articles#populater', as: :populater
  put 'wiper' => 'articles#wiper', as: :wiper
  
  put 'hmpopulater' => 'home_xis#populate', as: :hmpopulate

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'news#index', as: "news"
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
