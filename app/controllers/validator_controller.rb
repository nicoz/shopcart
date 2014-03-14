class ValidatorController < ApplicationController

  def new
    instance = params[:class].classify.constantize.new(params[:object])
    attribute = params[:attribute].to_s.to_sym
    instance.valid?
    #Rails.logger.info instance.methods 
    #Rails.logger.info instance.attribute
    render json: instance.errors[attribute].first
  end
  
  
end
