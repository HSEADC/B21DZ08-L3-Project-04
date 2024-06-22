class CollectionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_collection, only: [:show, :edit, :update, :destroy, :add_post, :remove_post]
  
    def index
        @collections = current_user.collections.order(created_at: :desc)
    end
  
    def show
      @collection = Collection.find(params[:id])
    end
  
    def new
      @collection = current_user.collections.build
      @post_id = params[:post_id]
      respond_to do |format|
        format.html { render partial: 'collections/form', locals: { collection: @collection } }
      end
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
        @post = Post.find(params[:post_id])
        @collection = current_user.collections.build(collection_params)
        respond_to do |format|
          if @collection.save
            if params[:post_id].present?
                @collection.posts << @post
            end
            format.html { redirect_to @post, notice: 'Collection was successfully created.' }
            format.turbo_stream do
              render turbo_stream: [
                turbo_stream.prepend("collections-list", partial: "collections/collection_card", locals: { collection: @collection }),
                turbo_stream.replace("modal", partial: "application/empty_modal") # Add this line to handle frame removal
              ]
            end
          else
            format.html { render :new }
            format.turbo_stream { render turbo_stream: turbo_stream.replace("modal", partial: "collections/form", locals: { collection: @collection }) }
          end
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
      redirect_to profile_url, notice: 'Collection was successfully destroyed.'
    end
  
    private
  
    def set_collection
      @collection = Collection.find(params[:id])
    end
  
    def collection_params
      params.require(:collection).permit(:name, :description, post_ids: [])
    end
  end
