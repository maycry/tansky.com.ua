class SessionsController < ApplicationController
	def new
	end

	def create
		salt = "$2a$10$tpM/96Pd5rHl0H9FNB01te";
		hash = "$2a$10$tpM/96Pd5rHl0H9FNB01tegpSds22gYA6rrUv7wVfTwtO3tB0Lpc.";
		if hash == BCrypt::Engine.hash_secret(params[:password], salt);
			session[:log_in] = "true"
			redirect_to return_point, :notice =>"Logged in!"
		else
			flash.now.alert = "Password invalid"
			render "new"
		end
	end

	def destroy
		session[:log_in] = nil
		redirect_to root_url, :notice => "Logged out!"
	end
end
