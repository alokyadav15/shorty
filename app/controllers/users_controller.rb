class UsersController < ApplicationController
  before_action :authenticate_admin!, except: [:new, :create,]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    # raise 
    captcha_message = "Wrong Captcha"
    if user_params["email"].blank? || !verify_recaptcha(model: @user, message: captcha_message)
      redirect_to new_user_path , :notice => "Fill email address please or enter captcha correctly  "
    else
      #testing email exists or not in our db ?
      @user = User.where(:email => user_params["email"]).first
        # if email exists sending email or if not then adding new user 
        if @user === nil
          @user = User.create(user_params)
          if @user.save 
            UserMailer.token_email(@user).deliver
            redirect_to root_path , :notice => "Api token sent , check your inbox "
          else
            render "new", :notice => "something is wrong "
          end
        else
          # if user  not nill means it found some data in our database 
          UserMailer.token_email(@user).deliver
          redirect_to root_path , :notice => "Api Token sent , check your inbox "
        end
    end



  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # raise
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email)
    end
end
