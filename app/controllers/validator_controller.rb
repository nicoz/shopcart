class ValidatorController < ApplicationController

  def new
    instance = params[:class].classify.constantize.new(validation_params)
    attribute = params[:attribute].to_s.to_sym
    #Rails.logger.info instance.attributes
    instance.valid?
    
    data = {message: instance.errors[attribute].first}
    render json: data
  end
  
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def validation_params
        params.require(:object).permit!
    end
end
