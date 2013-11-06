module SessionsHelper
	def logged
		session[:log_in] ? session[:log_in] : nil
	end
end
