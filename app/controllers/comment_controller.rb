class CommentController < ApplicationController
  before_action :authenticate_user
  
  def create
    @comment = Comment.new(
      commentable_id: params[:commentable_id],
      commentable_type: params[:commentable_type],
      user: current_user,
      content: params[:content]
    )
    @comment.save
    if params[:commentable_type] == 'Gossip'
      redirect_to Gossip.find(params[:commentable_id])
    else
      redirect_to Gossip.find(params[:gossip_id])
    end
  end

  def update
    @comment = Comment.find(params[:id])

    @comment.update(content: params[:content])
    redirect_to Gossip.find(params[:commentable])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @gossip_id = @comment.commentable_id
    @comment.destroy
    redirect_to Gossip.find(@gossip_id)
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
