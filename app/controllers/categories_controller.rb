class CategoriesController < ApplicationController
	
	before_action :set_category, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_admin, only: [:edit, :update, :destroy]

	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
	end

	def show
		@category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
	end

	def new
		# debugger
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "New category was successfully created."

			redirect_to categories_path
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update

		if @category.update(category_params)
			flash[:success] = "Category was successfully updated."

			redirect_to categories_path
		else
			render 'edit'
		end
	end

	def destroy
		@category.destroy
		flash[:danger] = "Category successfully deleted."
		redirect_to categories_path
	end

	private

		def category_params
			params.require(:category).permit(:name)
		end

		def set_category
			@category = Category.find(params[:id])
		end

		def require_admin
			if !current_user.admin?
				flash[:danger] = "This action is reserved for admin only."
				redirect_to root_path
			end
		end


end