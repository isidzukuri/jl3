class HomeController < ApplicationController
  def index
    @data = Content::Services::HomePage.new.call
    @meta_title = @data.dig(:metadata, :title)
    @meta_keywords = @data.dig(:metadata, :keywords)
    @meta_description = @data.dig(:metadata, :description)
  end
end
