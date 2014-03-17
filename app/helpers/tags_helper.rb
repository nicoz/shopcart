module TagsHelper
  include ActionView::Helpers::TranslationHelper
  
  def attribute_tag(object, attribute, params = {})
    result = ""
    if params[:form]
      result = show_form_field(object, attribute, params)
    else
      result = show_field_tag(object, attribute, params)
    end
    if [:all, :nonajax, :ajax].include? params[:validations]
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
          var test_type = '#{params[:validations].to_s}';
          $('form').on('blur', '\##{object.class.name.downcase}_#{attribute}', function() {
            validate_#{object.class.name.downcase}_#{attribute}($(this));
          });
          $('form').on('keyup', '\##{object.class.name.downcase}_#{attribute}', _.debounce(function(e) {
             var keyCode = e.keyCode || e.which; 

            if (keyCode != 9) { 
              validate_#{object.class.name.downcase}_#{attribute}($(this));
            }
            ;
        
            },300)
          );
          $('\##{object.class.name.downcase}_#{attribute}').bind('paste', function() {
            validate_#{object.class.name.downcase}_#{attribute}($(this));
          });
          
          function validate_#{object.class.name.downcase}_#{attribute}(element) {
            element.removeClass('field_with_errors');
            var error = false;
            if (test_type == 'all' || test_type == 'nonajax') {
              #{presence_of(object, attribute)}
              if (!error) { #{length_of(object, attribute)} }
            }
            if (test_type == 'all' || test_type == 'ajax') {
              if (!error) { #{ajax_test(object, attribute)}}
            }
          }
          
          function message_for_#{object.class.name.downcase}_#{attribute}(element, message) {
            element.addClass('field_with_errors');
            remove_message_for__#{object.class.name.downcase}_#{attribute}(element);
            var insert = _.bind(element.after, element);
            _.delay(insert, 200, \"<div class='alert alert-danger'><p><strong>#{attribute} </strong>\" + message + \"</p><div>\" )
          }
          
          function remove_message_for__#{object.class.name.downcase}_#{attribute}(element) {
            element.next('.alert').fadeOut(200, function() { $(this).remove(); });
            $('#general-alerts').fadeOut(200, function() { $(this).remove(); });
            element.parent('field_with_errors').remove();
          }
        </script>
      """
    end
    
    def presence_of(object, attribute)
      script = ""
      validator = nil
      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('PresenceValidator')
      end
      message = I18n.t "errors.messages.blank"
      if validator
        script += "var value = element.val();"
        
        script += """
          if (value == '' || value == 'undefined') {
            #{code_for_error(object, attribute, message)}
        """
      end
      script
    end
    
    def length_of(object, attribute)
      script = ""
      validator = nil
      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('LengthValidator')
      end
      
      if validator
        minimum = validator.options[:minimum]
        maximum = validator.options[:maximum]
        too_short_message = I18n.t "errors.messages.too_short", count:  minimum
        too_long_message = I18n.t "errors.messages.too_long", count: maximum

        script += "var value = element.val().length;"
        if minimum
          script += "var minimum = #{minimum};"
          script += """
            if (value < minimum) {
              #{code_for_error(object, attribute, too_short_message)}
          """
        end
        if maximum 
          script += "var maximum = #{maximum};"
          script += """
            if (value > maximum) {
              #{code_for_error(object, attribute, too_long_message)}
          """
        end
      end
      script
    end
    
    def ajax_test(object, attribute)
      script = """
        
        $.ajax({
          url: '/validator/new',
          type: 'GET',
          data: { 
            class: '#{object.class.name}',
            attribute: '#{attribute}',
            object: {'#{attribute}': element.val()}
          },
          beforeSend: remove_message_for__#{object.class.name.downcase}_#{attribute}(element),
        }).done(function(data) {
          if (data.message != null) {
            error = true;
            message_for_#{object.class.name.downcase}_#{attribute}(element, data.message)
          }
        });
      """
      script
    end
    
    def code_for_error(object, attribute, message) 
      """
        error = true;
        message_for_#{object.class.name.downcase}_#{attribute}(element, \"#{message} \")
        } else {
          remove_message_for__#{object.class.name.downcase}_#{attribute}(element);
        }
      """
    end
end
