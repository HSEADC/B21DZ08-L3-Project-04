class WelcomeController < ApplicationController
  before_action :set_locale, only: [:index, :about]

  def change_locale
    I18n.locale = params[:locale]
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end

  def index
    @subscription = Subscription.new
    @posts = Post.all
  end

  def about
    render layout: "about"
    @subscription = Subscription.new
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def search
    @items = PgSearch.multisearch(params['search'])
  end
end
