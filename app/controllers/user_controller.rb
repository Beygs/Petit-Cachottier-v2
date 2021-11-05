class UserController < ApplicationController
  before_action :authenticate_user, only: [:edit, :destroy]
  
  def new
  end

  def create
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      city: City.find_by(name: city_format(params[:city])),
      age: params[:age],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      is_admin: false
    )

    if @user.save

      if params[:remember]
        remember(@user)
      end

      log_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.authenticate(params[:password])
      if @user.update(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        city: City.find_by(name: city_format(params[:city])),
        age: params[:age],
        description: params[:description],
        email: @user.email,
        password: params[:password]
      )
        redirect_to @user
      else
        flash[:warning] = []

        @user.errors.full_messages.each do |error|
          flash[:warning] << error
        end
        render :edit
      end
    else
      flash[:warning] = []

      @user.errors.full_messages.each do |error|
        flash[:warning] << error
      end
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.destroy
    redirect_to root_path
  end

  private

  def city_format(city)
    require 'i18n'

    @city = I18n.transliterate(params[:city]).gsub("'", ' ').split.map { |w| w.capitalize }.join(' ')
  end

  def authenticate_user
    unless logged_in? && User.find(params[:id]) == current_user
      flash[:warning] = []
      flash[:warning] << 'Euh tu fais quoi là non mais dis-donc ?'
      redirect_to root_path
    end
  end
end
