class SavedCollectionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_collection
  
    def create
      if current_user.saved_collections.include?(@collection)
        redirect_to @collection, alert: 'Collection is already saved.'
      else
        current_user.saved_collections << @collection
        redirect_to @collection, notice: 'Collection was successfully saved to your profile.'
      end
    end
  
    def destroy
      if current_user.saved_collections.delete(@collection)
        redirect_to @collection, notice: 'Collection was successfully removed from your profile.'
      else
        redirect_to @collection, alert: 'Unable to remove collection.'
      end
    end
  
    private
  
    def set_collection
      @collection = Collection.find(params[:collection_id])
    end
  end
