class GossipController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
  end

  def create
    @gossip = Gossip.new(
      title: params[:title], 
      content: params[:content],
      user: User.find_by(first_name: 'anonymous')
    )

    tags = []
    
    params[:tags].join.split(';').each do |tag|
      tags << Tag.create(title: tag)
    end

    if @gossip.save
      tags.each do |tag|
        JoinTableGossipTag.create(
          gossip: @gossip,
          tag: tag
        )
      end
      redirect_to root_path
    else
      render new_gossip_path(@gossip)
    end
  end
end
