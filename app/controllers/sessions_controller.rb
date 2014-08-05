class SessionsController < ApplicationController
	def new
	end

	def create
		salt = "$2a$10$r8y63ZWAKfy3DJxz5jJxxO";
		hash = "$2a$10$r8y63ZWAKfy3DJxz5jJxxOmyZwhvQPzTYT5mJn8gZVqPzVu.j8/lq";
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
