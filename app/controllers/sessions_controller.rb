class SessionsController < ApplicationController
	def new
		# Luo kirjautumissivun
	end

	def create
		# Hakee käyttäjätunnusta vastaavan käyttäjän tietokannasta
		user = User.find_by username: params[:username]
		if user && user.authenticate(params[:password]) && !user.banned
			 # Jos käyttäjä on olemassa ja salasana täsmää...
			session[:user_id] = user.id # ...tallennetaan sessioon kirjautuneen käyttäjän id ja...
			redirect_to user, notice: "Welcome back!" # ...uudelleenohjataan käyttäjä omalle sivulleen
		elsif user.banned # Bannittu käyttäjä ei pääse kirjautumaan
			redirect_back(fallback_location: signin_path, notice: "Account #{params[:username]} has been banned. Please contact the administrator.")
		else
#			redirect_to :back, notice: "Username #{params[:username]} and/or password mismatch!"
			redirect_back(fallback_location: signin_path, notice: "Username #{params[:username]} and/or password mismatch!")
		end
	end

	def destroy
		# Tuhotaan sessio
		session[:user_id] = nil
		# Uudelleenohjataan pääsivulle
		redirect_to :root
	end
end