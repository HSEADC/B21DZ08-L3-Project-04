class Api::V1::Admin::PostsController < Api::V1::ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end