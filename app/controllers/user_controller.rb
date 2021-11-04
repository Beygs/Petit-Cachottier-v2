class UserController < ApplicationController
  def new
  end

  def create
    require 'i18n'

    @city = I18n.transliterate(params[:city]).gsub("'", ' ').split.map { |w| w.capitalize }.join(' ')

    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      city: City.find_by(name: @city),
      age: params[:age],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
