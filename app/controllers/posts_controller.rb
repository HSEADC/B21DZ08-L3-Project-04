class PostsController < ApplicationController
  layout "post-editor", only: [:new]
  load_and_authorize_resource
  before_action :set_post, only: %i[ show edit update destroy toggle_favourite toggle_like liked_by_user ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  def by_tag
    @posts = Post.tagged_with(params[:tag])
    render :index
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @total_comments_count = @post.total_comments_count
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post) }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post) }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def toggle_favourite
    
    post_user_ids = []

    @post.users_who_favourited.each do |user|
      post_user_ids << user.id
    end

    if post_user_ids.include?(current_user.id)
      current_user.posts_i_favourited.delete(@post)
    else
      current_user.posts_i_favourited << @post
    end

    set_post

  end

  def toggle_like
    post_user_ids = []

    @post.users_who_liked.each do |user|
      post_user_ids << user.id
    end

    if post_user_ids.include?(current_user.id)
      current_user.posts_i_liked.delete(@post)
    else
      current_user.posts_i_liked << @post
    end

    set_post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :text, :tag_list).merge(user_id: current_user.id)
    end
end
