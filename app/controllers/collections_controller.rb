class CollectionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_collection, only: [:show, :edit, :update, :destroy]
  
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
        @collection = current_user.collections.find(params[:id])
        @post = Post.find(params[:post_id])
    
        if @collection.posts << @post
          redirect_to @post, notice: 'Post was successfully added to the collection.'
        else
          redirect_to @post, alert: 'Unable to add post to collection.'
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
