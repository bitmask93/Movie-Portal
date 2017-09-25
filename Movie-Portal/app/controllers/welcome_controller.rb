class WelcomeController < ApplicationController
  def index
	session[:em]= nil
  end
end
