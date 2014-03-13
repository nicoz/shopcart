module TagsHelper
  include ActionView::Helpers::TranslationHelper
  
  def attribute_tag(object, attribute, params = {})
    result = ""
    if params[:form]
      result = show_form_field(object, attribute, params)
    else
      result = show_field_tag(object, attribute, params)
    end
    if [:all, :nonajax].include? params[:validations]
      result += validation_script_generator(object, attribute, params)
    else 
      result
    end
  end
  
  private
    def show_form_field(object, attribute, params)
      raw params[:form].text_field attribute, class: params[:class], placeholder: params[:placeholder], type: params[:type]
    end
    
    def show_field_tag(object, attribute, params)
      raw text_field_tag attribute, class: params[:class], placeholder: params[:placeholder], type: params[:type]
    end
    
    def validation_script_generator(object, attribute, params)
      raw """
        <script>
          $('form').on('blur', '\##{object.class.name.downcase}_#{attribute}', function() {
            console.log('blur');
            validate_#{object.class.name.downcase}_#{attribute}($(this));
          });
          $('form').on('keyup', '\##{object.class.name.downcase}_#{attribute}', function(e) {
            console.log('keyup');
             var keyCode = e.keyCode || e.which; 

            if (keyCode != 9) { 
              validate_#{object.class.name.downcase}_#{attribute}($(this));
            }
          });
          $('\##{object.class.name.downcase}_#{attribute}').bind('paste', function() {
            console.log('paste');
            validate_#{object.class.name.downcase}_#{attribute}($(this));
          });
          
          function validate_#{object.class.name.downcase}_#{attribute}(element) {
            element.next('.alert').remove();
            #{presence_of(object, attribute)}
          }
          
          function message_for_#{object.class.name.downcase}_#{attribute}(element, message) {
            console.log(\"#{attribute} \" + message);
            element.after(\"<div class='alert alert-danger'><p><strong>#{attribute} </strong>\" + message + \"</p><div>\");
          }
          
          function remove_message_for__#{object.class.name.downcase}_#{attribute}(element) {
            element.next('.alert').remove();
          }
        </script>
      """
    end
    
    def presence_of(object, attribute)
      script = ""
      validator = object.class._validators[attribute][0]
      message = I18n.t "errors.messages.blank"
      if validator.class.to_s.include?('PresenceValidator')
        script += "console.log('Validating presence of #{attribute} ');"
        script += "var value = element.val();"
        
        script += """
          if (value == '' || value == 'undefined') {
            message_for_#{object.class.name.downcase}_#{attribute}(element, \"#{message} \")
          } else {
            remove_message_for__#{object.class.name.downcase}_#{attribute}(element);
          }
        """
      end
    end
end
