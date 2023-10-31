class WelcomeController < ApplicationController
  before_action :set_locale, only: [:index, :about]

  def change_locale
    I18n.locale = params[:locale]
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end

  def index
    @subscription = Subscription.new
  end

  def about
    @subscription = Subscription.new
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
