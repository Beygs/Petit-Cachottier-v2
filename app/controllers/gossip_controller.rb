class GossipController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :update, :delete]
  
  def index
    @gossips = Gossip.all
  end
  
  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
  end

  def create
    @gossip = Gossip.new(
      title: params[:title], 
      content: params[:content],
      user: current_user
    )

    tags = []
    
    params[:tags].join.split(';').each do |tag|
      @new_tag = Tag.new(title: tag)
      if @new_tag.save
        tags << @new_tag
      else
        tags << Tag.find_by(title: tag)
      end
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
      flash[:warning] = []

      @gossip.errors.full_messages.each do |error|
        flash[:warning] << error
      end
      redirect_to new_gossip_path
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
    @tags = @gossip.tags.map { |t| t.title }.join(';')
  end

  def update
    @gossip = Gossip.find(params[:id])

    tags = []
    
    params[:tags].join.split(';').each do |tag|
      @new_tag = Tag.new(title: tag)
      if @new_tag.save
        tags << @new_tag
      else
        tags << Tag.find_by(title: tag)
      end
    end

    if @gossip.update(title: params[:title], content: params[:content])
      JoinTableGossipTag.where(gossip: @gossip).destroy_all
      tags.each do |tag|
        JoinTableGossipTag.create(
          gossip: @gossip,
          tag: tag
        )
      end
      redirect_to @gossip
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path
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
