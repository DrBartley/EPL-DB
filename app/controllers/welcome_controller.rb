class WelcomeController < ApplicationController
	# before_filter :authenticate_user!, except: [:index]
	layout :choose_layout
	
	def index
	end

	def choose_layout
		# user_signed_in? ? "angular" : "application"
		"angular"
	end
end
