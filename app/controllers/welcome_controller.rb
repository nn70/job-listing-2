class WelcomeController < ApplicationController
  def index
    flash[:notice] ="fuck"
  end
end
