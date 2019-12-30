class CommentsController < ApplicationController

	before_action :set_commentable
	before_action :require_user

	def create
		@comment = @commentable.comments.new(comment_params)


		if @comment.save
			flash[:success] = "Comment successfully posted."
			redirect_to @commentable
		else
			if(@comment.errors.any?)
				@comment.errors.full_messages.each do |error|
					flash[:danger] = error
				end
				redirect_to @commentable
			end
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:comment)
		end

		def set_commentable
		   	params.each do |name, value|
		     	 if name =~ /(.+)_id$/
		       		 @commentable = $1.classify.constantize.find(value)
		     	 end
		    end
  		end
end