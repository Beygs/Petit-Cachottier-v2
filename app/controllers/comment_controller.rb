class CommentController < ApplicationController
  def create
    @comment = Comment.new(
      commentable: Gossip.find(params[:commentable]),
      user: User.find_by(first_name: 'anonymous'),
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
end
