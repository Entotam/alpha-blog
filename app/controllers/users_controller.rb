class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update]

	def index
		@user = User.all
	end

	def show
		@article = @user.articles
	end

	def new
		@user = User.new
	end

	def edit
	end

	def update	
		if @user.save
			flash[:notice] = "Your profile has succesfuly updated"
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = current_user
			flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
			redirect_to root_path
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user
			flash[:alert] = "You can edit only your account"
			redirect_to @user
		end
	end
end