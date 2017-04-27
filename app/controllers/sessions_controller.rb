class SessionsController < ApplicationController
	def new
		# Luo kirjautumissivun
	end

	def create
		# Hakee käyttäjätunnusta vastaavan käyttäjän tietokannasta
		user = User.find_by username: params[:username]
		if user
			if user.authenticate(params[:password]) && !user.banned
				 # Jos käyttäjä on olemassa ja salasana täsmää...
				session[:user_id] = user.id # ...tallennetaan sessioon kirjautuneen käyttäjän id ja...
				redirect_to user, notice: "Welcome back, #{params[:username]}!" # ...uudelleenohjataan käyttäjä omalle sivulleen
			elsif user.banned # Bannittu käyttäjä ei pääse kirjautumaan
				redirect_back(fallback_location: signin_path, notice: "Account #{params[:username]} has been banned. 🤔 Please contact the administrator.")
			end
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

	def create_oauth
		user = User.find_by username: env["omniauth.auth"].info.nickname
#		byebug
		if user && !user.banned
			session[:user_id] = user.id
			redirect_to user, notice: "Welcome back, #{user.username}!"
		elsif user.banned # Bannittu käyttäjä ei pääse kirjautumaan
			redirect_back(fallback_location: signin_path, notice: "Account #{user.username} has been banned. Please contact the administrator.")
		else
			redirect_back(fallback_location: signin_path, notice: "Username #{env["omniauth.auth"].info.nickname} not found! Create Ratebeer account first.")
		end
	end
end