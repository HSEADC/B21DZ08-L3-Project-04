class Api::V1::PostsController < Api::V1::ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    jti = request.headers['Authorization']

    user = User.find_by_jti(decrypt_payload[0]['jti'])
    @post = user.posts.new(post_params)

      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity 
      end

  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end