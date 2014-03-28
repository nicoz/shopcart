module PaypalHelper
  def create_buy_button( account, id_compra, currency_code, price, mode )
    url = "https://www.paypal.com/cgi-bin/webscr"

    if mode
      url = "https://www.sandbox.paypal.com/cgi-bin/webscr"
    end

    raw "<form target=\"paypal\"  action=\"#{url}\" method=\"post\">
      <input type=\"hidden\" name=\"cmd\" value=\"_xclick\">
      <input type=\"hidden\" name=\"business\" value=\"#{account}\">
      <input type=\"hidden\" name=\"currency_code\" value=\"#{currency_code}\">
      <input type=\"hidden\" name=\"item_name\" value=\"Orden de compra \##{id_compra}\">
      <input type=\"hidden\" name=\"amount\" value=\"#{price}\">
      <input type=\"hidden\" name=\"notify_url\" value=\"#{request.domain}#{paypal_notification_path( id_compra )}\">
      <input type=\"image\" src=\"http://www.paypalobjects.com/es_XC/i/btn/btn_buynow_LG.gif\" border=\"0\" name=\"submit\" alt=\"Make payments with PayPal - it's fast, free and secure!\">
    </form>"
  end
end
