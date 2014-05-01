class ShortsController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :destroy]
  before_action :set_short, only: [:show, :edit, :update, :redirect ,:destroy]

  # GET /shorts
  # GET /shorts.json
  def index
    @shorts = Short.all
  end

  # GET /shorts/1
  # GET /shorts/1.json
  def show
  end

  # GET /shorts/new
  def new
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
        format.html { redirect_to @short, notice: 'Short was successfully created.' }
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
        format.html { redirect_to @short, notice: 'Short was successfully updated.' }
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
     redirect_to @short.full
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
