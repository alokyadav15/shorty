class ShortsController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :destroy, :index]
  before_action :set_short, only: [:show, :edit, :update, :redirect ,:destroy, :delete]

  # GET /shorts
  # GET /shorts.json
  def index
    @shorts = Short.all
  end

  # GET /shorts/1
  # GET /shorts/1.json
  def show
    # raise
    if session[:created_at] && session[:created_at] < 2.minutes.ago
      reset_session
    end
    @plain_url = Short.decrypt(@short)
  end

  def delete
    if request.method.to_sym === :DELETE || request.method.to_sym == :POST
      if params[:delete_token] == @short.delete_token
        @short.destroy
        flash[:notice] = "Deleted successfully"
        redirect_to root_path
      else
        flash[:notice] = "Something Went Wrong"
        redirect_to delete_path
      end
    else
      if @short.nil?
        redirect_to root_path
      else
        @short
      end
    end
  end

  # GET /shorts/new
  def new
    # reset_session
    @short = Short.new
  end

  # GET /shorts/1/edit
  def edit
  end

  # POST /shorts
  # POST /shorts.json
  def create
    # raise
    @short = Short.new(short_params)
    @short.short = "http://#{request.host_with_port.to_s}"
    respond_to do |format|
      if @short.save
        session[:delete_token] = @short.delete_token
        session[:created_at] = Time.now

        format.html { redirect_to @short, notice: 'URL has been shorted successfully' }
        format.json { render :show, status: :created, location: @short }
      else
        format.html { render :new }
        format.json { render json: @short.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shorts/1
  # PATCH/PUT /shorts/1.json
  def update
    respond_to do |format|
      if @short.update(short_params)
        format.html { redirect_to @short, notice: 'URL has been updated successfully' }
        format.json { render :show, status: :ok, location: @short }
      else
        format.html { render :edit }
        format.json { render json: @short.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shorts/1
  # DELETE /shorts/1.json

 def redirect
   if @short.nil?
     redirect_to "/"
   else
    # raise
     @plain_url = Short.decrypt(@short)
      redirect_to @plain_url
   end
 end

  def destroy
    @short.destroy
    respond_to do |format|
      format.html { redirect_to shorts_url }
      format.json { head :no_content }
    end
  end

  private

    #negative captcha 

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_short
      @short = Short.where(:slug => params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_params
      params.require(:short).permit(:full,:slug)
    end
end
