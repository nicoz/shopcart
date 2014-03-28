class OrdenCompraController < ApplicationController
  protect_from_forgery :except => [:paypal_notification]

  def index
  end

  def new
    #paypal = Service.where( name: "paypal" ).first
    #@account = ServiceInformation.where( service_id: paypal.id AND key: "account").first
    @account = "mc2geek-facilitator@gmail.com"
    @orden_compra = OrdenCompra.new
    @orden_compra.estado = false
    @orden_compra.total  = 12.99
    @orden_compra.id = 23
  end

  def paypal_notification
    Rails.logger.info "-----------------------------PayPalNotification-----------------------------"
    Rails.logger.info params
    response = validate_IPN_notification(request.raw_post)

    case response
    when "VERIFIED"
      if params[:payment_status] == "Completed"
        orden_compra = OrdenCompra.where( :id => params[:custom] ).first
        orden_compra.is_paid = true
        orden_compra.save
      end
        # check that paymentStatus=Completed
        # check that txnId has not been previously processed
        # check that receiverEmail is your Primary PayPal email
        # check that paymentAmount/paymentCurrency are correct
        # process payment
    when "INVALID"
      # log for investigation
    else
      # error
    end

    render :nothing => true
  end

  protected
  def validate_IPN_notification(raw)
    uri = URI.parse( 'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate' )
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, raw,
                         'Content-Length' => "#{raw.size}",
                         'User-Agent' => "webkit"
                       ).body
  end
end
