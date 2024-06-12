class CollectionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_collection, only: [:show, :edit, :update, :destroy, :add_post, :remove_post]
  
    def index
        @collections = current_user.collections
    end
  
    def show
    end
  
    def new
      @collection = current_user.collections.build
      @post_id = params[:post_id]
    end

    def add_post
      @post = Post.find(params[:post_id])
        @collection.posts << @post
        respond_to do |format|
          format.html { redirect_to @post, notice: 'Post was successfully added to the collection.' }
          format.turbo_stream { render turbo_stream: turbo_stream.replace("collection_#{@collection.id}_post_#{@post.id}", partial: "collections/toggle_add_button", locals: { collection: @collection, post: @post }) }
      end
    end
  
    def remove_post
      @post = Post.find(params[:post_id])
      @collection.posts.delete(@post)
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Post was successfully removed from the collection.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("collection_#{@collection.id}_post_#{@post.id}", partial: "collections/toggle_add_button", locals: { collection: @collection, post: @post }) }
      end
    end
  
    def create
      @collection = current_user.collections.build(collection_params)
      if @collection.save
        if params[:post_id].present?
          post = Post.find(params[:post_id])
          @collection.posts << post
        end
        redirect_to @collection, notice: 'Collection was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @collection.update(collection_params)
        redirect_to @collection, notice: 'Collection was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @collection.destroy
      redirect_to collections_url, notice: 'Collection was successfully destroyed.'
    end
  
    private
  
    def set_collection
      @collection = Collection.find(params[:id])
    end
  
    def collection_params
      params.require(:collection).permit(:name, :description, post_ids: [])
    end
  end
