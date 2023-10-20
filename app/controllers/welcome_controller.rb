class WelcomeController < ApplicationController
  def index
    @subscription = Subscription.new
  end

  def about
  end
end
