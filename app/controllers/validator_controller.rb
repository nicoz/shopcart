class ValidatorController < ApplicationController

  def new
    instance = params[:class].classify.constantize.new(params[:object])
    attribute = params[:attribute].to_s.to_sym
    
    instance.valid?
    
    data = {message: instance.errors[attribute].first}
    render json: data
  end
  
  
end
