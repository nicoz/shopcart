module ErrorsHelper
  def error_messages(important, message, object)
    content_tag :div, :class => "alert alert-danger alert-dismissable", :id => "general-alerts" do
      concat content_tag :button, "X", type: "button", 
        class: "close", data: {dismiss: "alert"}, "aria-hidden" => true
      concat content_tag :p, show_message(important, message)
      concat show_errors(object)
    end
  end
  
  private
    def show_message(important, message)
      result = content_tag :strong, important
      result += " " + message
    end
    
    def show_errors(object)
      result = ""
      object.errors.map do |key, value|
        result += content_tag :p, "#{key} #{value}" if object.errors[key].first == value
      end
      raw result
    end
end
