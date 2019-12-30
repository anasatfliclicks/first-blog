class PhotosController < ApplicationController

	before_action :set_photoable

	def create
		# debugger
	 # 	puts @photoable.photo.class		
		@photoable.photo = Photo.new(photo_params)
		@photo = @photoable.photo

		if @photo.save
			flash[:success] = "Photo successfully uploaded."
			redirect_to @photoable
		end
	end

	private

		def photo_params
			params.require(:photo).permit(:image)
		end

		def set_photoable
		   	params.each do |name, value|
		     	 if name =~ /(.+)_id$/
		       		 @photoable = $1.classify.constantize.find(value)
		     	 end
		    end
  		end
end