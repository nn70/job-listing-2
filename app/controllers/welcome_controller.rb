class WelcomeController < ApplicationController
  def index
    flash[:notice] ="泥嚎"
  end
end
