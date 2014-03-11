class ConfigurationController < ApplicationController

  def index
    @title = "System Installation"
    render layout: "administration"
  end
end
