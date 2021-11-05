class LikesController < ApplicationController
  before_action :authenticate_user
  
  def create
    @like = Like.create(
      likeable_id: params[:likeable_id],
      likeable_type: params[:likeable_type],
      user: current_user
    )
    begin
      if @like.likeable.commentable_type == 'Gossip'
        redirect_to gossip_path(@like.likeable.commentable)
      else
        redirect_to gossip_path(@like.likeable.commentable.commentable)
      end
    rescue
      redirect_to gossip_path(params[:likeable_id])
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    begin
      if @like.likeable.commentable_type == 'Gossip'
        redirect_to gossip_path(@like.likeable.commentable)
      else
        redirect_to gossip_path(@like.likeable.commentable.commentable)
      end
    rescue
      redirect_to gossip_path(@like.likeable_id)
    end
  end

  private

  def authenticate_user
    unless logged_in?
      flash[:warning] = []
      flash[:warning] << 'Connecte-toi stp.'
      redirect_to new_session_path
    end
  end
end
