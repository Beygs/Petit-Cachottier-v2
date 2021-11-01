class ActivePagesController < ApplicationController
  def welcome
    @first_name = params[:first_name]
  end
end
