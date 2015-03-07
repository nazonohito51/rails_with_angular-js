class TemplatesController < ApplicationController
  # def index
  #   render template: "templates/index.html"
  # end

  def template
    render template: "templates/#{params[:path]}", layout: nil
  end
end
