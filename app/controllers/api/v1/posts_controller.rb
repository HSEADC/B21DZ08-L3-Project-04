class Api::V1::PostsController < Api::V1::ApplicationController
  def index
    @pins = Pin.all
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def create
    user = User.find_by_jti(decrypt_payload[0]['jti'])
    @pin = user.pins.new(pin_params)

    if @pin.save
      render json: @pin, status: :created
    else
      render json: @pin.errors, status: :unprocessable_entity
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :pin_image, :tag_list, :category_list)
  end
end