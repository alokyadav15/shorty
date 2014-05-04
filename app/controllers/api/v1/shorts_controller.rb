module Api
	module V1
		class ShortsController < ApplicationController
			before_action :set_short, only: [:show, :create]
			before_filter :restrict_access
  			skip_before_action :verify_authenticity_token
			respond_to :json

			def show
				# raise
				@short = Short.where(:slug => params[:slug]).first
				@plain_url = Short.decrypt(@short)
			end
			def create
				@short = Short.new(short_params)
    			@short.short = "http://#{request.host_with_port.to_s}"
				respond_to do |format|
			      if @short.save
			        format.json { render :show, status: :created, location: @short }
			      else
			        format.json { render json: @short.errors, status: :unprocessable_entity }
			      end
			    end
			end


		  private
		    # Use callbacks to share common setup or constraints between actions.
		    def set_short
		      @short = Short.where(:slug => params[:slug]).first
		    end

		    # Never trust parameters from the scary internet, only allow the white list through.
		    def short_params
		      params.require(:short).permit(:full,:slug)
		    end
		    private 

			def restrict_access
				Rails.logger.info "  [HTTP_AUTHORIZATION] #{request.headers['HTTP_AUTHORIZATION'].inspect}"
				authenticate_or_request_with_http_token do |token, options|
					User.where(:current_token => token).exists?
				end
			end
		end


	end
end