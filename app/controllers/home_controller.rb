class HomeController < ApplicationController
  def index
    @data = Content::Services::HomePage.new.call
  end
end
