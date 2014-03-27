module PaypalHelper
  def create_cart_button( account, item, item_amount, currency_code, price, mode )
    url = "https://www.paypal.com/cgi-bin/webscr"

    if mode
      url = "https://www.sandbox.paypal.com/cgi-bin/webscr"
    end

    "<form target=\"paypal\"  action=\"#{url}\" method=\"post\">
      <input type=\"hidden\" name=\"cmd\" value=\"_cart\">
      <input type=\"hidden\" name=\"add\" value=\"#{item_amount}\">
      <input type=\"hidden\" name=\"business\" value=\"#{account}\">
      <input type=\"hidden\" name=\"currency_code\" value=\"#{currency_code}\">
      <input type=\"hidden\" name=\"item_name\" value=\"#{item}\">
      <input type=\"hidden\" name=\"amount\" value=\"#{price}\">
      <input type=\"hidden\" name=\"notify_url\" value=\"\">
      <input type=\"image\" src=\"http://www.paypalobjects.com/es_XC/i/btn/btn_buynow_LG.gif\" border=\"0\" name=\"submit\" alt=\"Make payments with PayPal - it's fast, free and secure!\">
    </form>"
  end

  def create_cart_detail_button( account, mode )
    url = "https://www.paypal.com/cgi-bin/webscr"

    if mode
      url = "https://www.sandbox.paypal.com/cgi-bin/webscr"
    end

    "<form name=\"_cart\" action=\"#{url}\" method=\"post\">
      <input type=\"hidden\" name=\"cmd\" value=\"_cart\">
      <input type=\"hidden\" name=\"display\" value=\"1\">
      <input type=\"hidden\" name=\"notify_url\" value=\"\">
      <input type=\"hidden\" name=\"business\" value=\"#{account}\">
      <input type=\"image\" src=\"http://www.paypalobjects.com/es_XC/i/btn/btn_buynow_LG.gif\" border=\"0\" name=\"submit\" alt=\"Make payments with PayPal - it's fast, free and secure!\">
    </form>"
  end
end
