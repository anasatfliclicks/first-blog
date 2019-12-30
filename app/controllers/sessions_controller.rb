class SessionsController < ApplicationController
	
	def new

	end

	def create
		# debugger
		user = User.find_by(email: params[:session][:email].downcase)

		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You've successfully logged in"

			redirect_to user_path(user)
		else
			flash.now[:danger] = "You've entered incorrect credentials"
			render 'new'
		end
	end

	def destroy
		if session[:user_id]
			session[:user_id] = nil
			flash[:success] = "You've successfully logged out."
		else
			flash[:danger] = "Please login first to proceed to this action."
		end

		redirect_to root_path
	end

end