class CommentController < ApplicationController
  def create
    @comment = Comment.new(
      commentable: Gossip.find(params[:commentable]),
      user: current_user,
      content: params[:content]
    )
    @comment.save
    redirect_to Gossip.find(params[:commentable])
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
end
