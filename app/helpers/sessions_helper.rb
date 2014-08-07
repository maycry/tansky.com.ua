module SessionsHelper
	def logged
		session[:log_in]
	end
end
