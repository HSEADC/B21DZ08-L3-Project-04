class ProfilesController < ApplicationController
  # load_and_authorize_resource
  before_action :set_profile, only: %i[ show edit update destroy ]

  def show
    @user = @profile.user
    @posts = @user.posts
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(user_params)
    @profile = @user.build_profile(profile_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:username, :about, :avatar, :login)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
