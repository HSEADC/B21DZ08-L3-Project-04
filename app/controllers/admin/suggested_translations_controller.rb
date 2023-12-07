class Admin::SuggestedTranslationsController < ApplicationController
  before_action :set_suggested_translation, only: %i[ show edit update destroy ]

  # GET /suggested_translations or /suggested_translations.json
  def index
    @suggested_translations = SuggestedTranslation.all
  end

  # GET /suggested_translations/1 or /suggested_translations/1.json
  def show
  end

  # GET /suggested_translations/new
  def new
    @suggested_translation = SuggestedTranslation.new
  end

  # GET /suggested_translations/1/edit
  def edit
  end

  # POST /suggested_translations or /suggested_translations.json
  def create
    @suggested_translation = SuggestedTranslation.new(suggested_translation_params)

    respond_to do |format|
      if @suggested_translation.save
        format.html { redirect_to admin_suggested_translation_url(@suggested_translation), notice: "Suggested translation was successfully created." }
        format.json { render :show, status: :created, location: @suggested_translation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @suggested_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggested_translations/1 or /suggested_translations/1.json
  def update
    respond_to do |format|
      if @suggested_translation.update(suggested_translation_params)
        format.html { redirect_to admin_suggested_translation_url(@suggested_translation), notice: "Suggested translation was successfully updated." }
        format.json { render :show, status: :ok, location: @suggested_translation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @suggested_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggested_translations/1 or /suggested_translations/1.json
  def destroy
    @suggested_translation.destroy

    respond_to do |format|
      format.html { redirect_to admin_suggested_translations_url, notice: "Suggested translation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggested_translation
      @suggested_translation = SuggestedTranslation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def suggested_translation_params
      params.require(:suggested_translation).permit(:user_id, :post_id, :language, :body)
    end
end
