EPLDB::Application.routes.draw do

  devise_scope :user do
    get '/api/current_user' => 'users/sessions#show_current_user', as: 'show_current_user'
    post '/api/check/is_user' => 'users/users#is_user', as: 'is_user'
  end

  get '/user/sign_out' => 'welcome#index'

  devise_for :users,
  :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "registrations"
  }

  get '/dashboard' => 'welcome#dashboard'
  get '/settings' => 'welcome#dashboard'
  root to: 'welcome#index'

  get 'possjson/:team' => 'fixtures#livepossjson'
  get 'shotjson/:team' => 'fixtures#liveshotjson'
  get 'targetjson/:team' => 'fixtures#livetargetjson'
  get 'cornerjson/:team' => 'fixtures#livecornerjson'
  get 'fouljson/:team' => 'fixtures#livefouljson'

  get 'fixturesjson/:team' => 'fixtures#fixturesjson'
  get 'scoresjson' => 'fixtures#scores'

  get 'hometeam/:team' => 'fixtures#hometeam'
  get 'awayteam/:team' => 'fixtures#awayteam'

  get 'tablejson' => 'fixtures#tablejson'

  get 'formjson/:team' => 'fixtures#formjson'
  get "/otherformjson/:team" => "fixtures#otherformjson"

  get 'megajson/:team' => 'fixtures#megajson'

  get 'topscorers/:team' => 'fixtures#topscorers'

  get 'liveposspie' => 'fixtures#liveposspie'

  get "news/index"

  get "/prematchjson/:team" => "fixtures#prematchjson"

end