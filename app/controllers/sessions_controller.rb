class SessionsController < ApplicationController
	def new
		# Luo kirjautumissivun
	end

# Create-metodiin tarvittava muutos Rails 5.1:tä varten?
# DEPRECATION WARNING: `redirect_to :back` is deprecated and will be removed from Rails 5.1.
# Please use `redirect_back(fallback_location: fallback_location)` where `fallback_location` represents
# the location to use if the request has no HTTP referer information.

	def create
		# Hakee käyttäjätunnusta vastaavan käyttäjän tietokannasta
		user = User.find_by username: params[:username]
		if user && user.authenticate(params[:password]) # Jos käyttäjä on olemassa ja salasana täsmää...
			session[:user_id] = user.id # ...tallennetaan sessioon kirjautuneen käyttäjän id ja...
			redirect_to user, notice: "Welcome back!" # ...uudelleenohjataan käyttäjä omalle sivulleen
		else
			redirect_to :back, notice: "Username #{params[:username]} and/or password mismatch!"
		end
	end

	def destroy
		# Tuhotaan sessio
		session[:user_id] = nil
		# Uudelleenohjataan pääsivulle
		redirect_to :root
	end
end