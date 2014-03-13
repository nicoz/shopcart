module TagsHelper
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
          $('form').on('change', '\##{object.class.name.downcase}_#{attribute}', function() {
            console.log('change');
            validate_#{object.class.name.downcase}_#{attribute}($(this));
          });
          $('form').on('keyup', '\##{object.class.name.downcase}_#{attribute}', function() {
            console.log('keyup');
            validate_#{object.class.name.downcase}_#{attribute}($(this));
          });
          $('\##{object.class.name.downcase}_#{attribute}').bind('paste', function() {
            console.log('paste');
            validate_#{object.class.name.downcase}_#{attribute}($(this));
          });
          
          function validate_#{object.class.name.downcase}_#{attribute}(element) {
            #{presence_of(object, attribute)}
          }
        </script>
      """
    end
    
    def presence_of(object, attribute)
      script = ""
      if object.class._validators[attribute][0].class.to_s.include?('PresenceValidator')
        script += "console.log('Validating presence of #{attribute} ');"
        script += "var value = element.val();"
        
        script += """
          if (value == '' || value == 'undefined') {
            console.log('error detected on #{attribute}');
          }
        """
      end
    end
end
