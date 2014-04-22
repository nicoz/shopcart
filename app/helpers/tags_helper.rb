module TagsHelper
  include ActionView::Helpers::TranslationHelper

  def attribute_tag( object, attribute, params = {} )
    result = ""

    if params[:form]
      result = show_form_field( object, attribute, params )
    else
      result = show_field_tag( object, attribute, params )
    end

    if [:all, :nonajax, :ajax].include? params[:validations]
      result += validation_script_generator( object, attribute, params )
    else 
      result
    end
  end

  private
    def show_form_field( object, attribute, params )
      raw params[:form].text_field attribute.to_sym, class: params[:class], placeholder: params[:placeholder], type: params[:type], data: { attribute: attribute }
    end

    def show_field_tag(object, attribute, params)
      raw text_field_tag attribute.to_sym, class: params[:class], placeholder: params[:placeholder], type: params[:type], data: { attribute: attribute }, value: object[attribute]
    end

    def validation_script_generator(object, attribute, params)
      raw """
        <script>
          var test_type = '#{params[:validations].to_s}';
          $('form').on('blur', '\##{object.class.name.underscore}_#{attribute}', function() {
            validate_#{object.class.name.underscore}_#{attribute}($(this));
          });
          $('form').on('keyup', '\##{object.class.name.underscore}_#{attribute}', _.debounce(
            function(e) {
              var keyCode = e.keyCode || e.which; 
              if (keyCode != 9) { 
                validate_#{object.class.name.underscore}_#{attribute}($(this));
              };
            },300)
          );

          $('\##{object.class.name.downcase}_#{attribute}').bind('paste', function() {
            validate_#{object.class.name.underscore}_#{attribute}($(this));
          });

          function validate_#{object.class.name.underscore}_#{attribute}(element) {
            element.removeClass('field_with_errors');
            var error = false;

            if (test_type == 'all' || test_type == 'nonajax') {
              #{presence_of(object, attribute)}
              if (!error) { #{confirmation_of( object, attribute )} }
              if (!error) { #{numericality_of( object, attribute )} }
              if (!error) { #{   exclusion_of( object, attribute )} }
              if (!error) { #{   inclusion_of( object, attribute )} }
              if (!error) { #{     absence_of( object, attribute )} }
              if (!error) { #{      format_of( object, attribute )} }
              if (!error) { #{      length_of( object, attribute )} }
            }
            console.log(test_type);
            if (test_type == 'all' || test_type == 'ajax') {
              if (!error) { #{ajax_test(object, attribute)}}
            }

            if (!error && test_type == 'nonajax') {
              remove_message_for__#{object.class.name.underscore}_#{attribute}(element);
            }
          }

          function message_for_#{object.class.name.underscore}_#{attribute}(element, message) {
            element.addClass('field_with_errors');
            var error_message = element.next('.alert').find('p');
            if (element.next('.alert').find('p').length > 0) {
              error_message.html(\"<strong>#{attribute} </strong>\" + message );
            } else {
              element.after(\"<div class='alert alert-danger'><p><strong>#{attribute} </strong>\" + message + \"</p><div>\" );
            }
          }

          function remove_message_for__#{object.class.name.underscore}_#{attribute}(element) {
            element.next('.alert').remove();
            $('#general-alerts').fadeOut(200, function() { $(this).remove(); });
            element.parent('field_with_errors').remove();
          }
        </script>
      """
    end

    def presence_of(object, attribute)
      script = ""
      validator = nil

      if object.class._validators
        object.class._validators[attribute].each do |v|
          validator = v if v.class.to_s.include?('PresenceValidator')
        end
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

    def numericality_of(object, attribute)
      script = ""
      validator = nil

      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('NumericalityValidator')
      end

      if validator
        greater_than             = validator.options[:greater_than]
        greater_than_or_equal_to = validator.options[:greater_than_or_equal_to]
        equal_to                 = validator.options[:equal_to]
        less_than_or_equal_to    = validator.options[:less_than_or_equal_to]
        less_than                = validator.options[:less_than]
        odd                      = validator.options[:odd]
        even                     = validator.options[:even]

        not_a_number_message             = I18n.t "errors.messages.not_a_number"
        greater_than_message             = I18n.t "errors.messages.greater_than", count: greater_than
        greater_than_or_equal_to_message = I18n.t "errors.messages.greater_than_or_equal_to", count: greater_than_or_equal_to
        equal_to_message                 = I18n.t "errors.messages.equal_to", count: equal_to
        less_than_or_equal_to_message    = I18n.t "errors.messages.less_than_or_equal_to", count: less_than_or_equal_to
        less_than_message                = I18n.t "errors.messages.less_than", count: less_than
        odd_message                      = I18n.t "errors.messages.odd"
        even_message                     = I18n.t "errors.messages.even"

        script += "var value = element.val();"
        script += """
          var regexp = /^[\\d]+$/;
          var match = regexp.exec( value );

          if ( match == null ) {
            #{code_for_error( object, attribute, not_a_number_message )}
        """

        if greater_than
          script += """
            else if ( value <= #{greater_than} ) {
              #{code_for_error( object, attribute, greater_than_message )}
          """
        end

        if greater_than_or_equal_to
          script += """
            else if ( value < #{greater_than_or_equal_to} ) {
              #{code_for_error( object, attribute, greater_than_or_equal_to_message )}
          """
        end

        if equal_to
          script += """
            else if ( value != #{equal_to} ) {
              #{code_for_error( object, attribute, equal_to_message )}
          """
        end

        if less_than_or_equal_to
          script += """
            else if ( value > #{less_than_or_equal_to} ) {
              #{code_for_error( object, attribute, less_than_or_equal_to_message )}
          """
        end

        if less_than
          script += """
            else if ( value >= #{less_than} ) {
              #{code_for_error( object, attribute, less_than_message )}
          """
        end

        if odd
          script += """
            else if ( value % 2 == 0 ) {
              #{code_for_error( object, attribute, odd_message )}
          """
        end

        if even
          script += """
            else if ( value % 2 != 0 ) {
              #{code_for_error( object, attribute, even_message )}
          """
        end

        script
      end

      script
    end

    def confirmation_of( object, attribute )
      script = ""
      validator = nil

      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('ConfirmationValidator')
      end

      if validator
        confirmation_message = I18n.t "errors.messages.confirmation"

        script += """
          var element_id = element.attr( \"id\" );
          var value = element.val();
          var confirmation_element = $( \"#\" 
                                        + element_id 
                                        + \"_confirmation\"
          );
          var confirmation_value   = confirmation_element.val();

          $('form').on( 'blur', '#' + confirmation_element.attr( \"id\" ), function() {
            validate_#{object.class.name.underscore}_#{attribute}(element);
          });

          $('form').on('keyup', '#' + confirmation_element.attr( \"id\" ), _.debounce(
            function(e) {
              var keyCode = e.keyCode || e.which; 
              if (keyCode != 9) { 
                validate_#{object.class.name.underscore}_#{attribute}(element);
              };
            },300)
          );

          if ( value != confirmation_value ) {
            #{code_for_error( object, attribute, confirmation_message )}
        """
      end

      script
    end

    def acceptance_of(object, attribute)
      script = ""
      validator = nil

      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('AcceptanceValidator')
      end

      if validator
        must_be_accepted_message = I18n.t "errors.messages.must_be_accepted"

        script += """
          var value = element.checked;
          if( !value ){
            #{code_for_error( object, attribute, not_a_number_message )}
        """
      end
    end

    def inclusion_of(object, attribute)
      script = ""
      validator = nil

      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('InclusionValidator')
      end

      if validator
        message = I18n.t "errors.messages.inclusion"

        list = validator.options[:in]

        script += """
          var value = element.val();
          var list = #{list};

          if ( list.indexOf( value ) < 0 ) {
            #{code_for_error( object, attribute, message )}
        """

        script
      end
    end

    def exclusion_of(object, attribute)
      script = ""
      validator = nil

      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('ExclusionValidator')
      end

      if validator
        message = I18n.t "errors.messages.exclusion"

        list = validator.options[:in]

        script += """
          var value = element.val();
          var list = #{list};

          if ( list.indexOf( value ) > -1 ) {
            #{code_for_error( object, attribute, message )}
        """

        script
      end
    end

    def format_of( object, attribute )
      script = ""
      validator = nil

      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?( 'FormatValidator' )
      end

      if validator
        message = I18n.t "errors.messages.invalid"

        format = validator.options[:with]
        format = json_regexp( format ).to_s

        script += """
          var value  = element.val();
          var format = /#{format}/;
          var match  = format.exec( value );

          if ( match == null ) {
            #{code_for_error( object, attribute, message )}
        """
      end

      script
    end

    def absence_of(object, attribute)
      script = ""
      validator = nil

      object.class._validators[attribute].each do |v|
        validator = v if v.class.to_s.include?('AbsenceValidator')
      end

      if validator
        message = I18n.t "errors.messages.presence"

        script += "var value = element.val();"

        script += """
          if (value != '' && value != 'undefined') {
            #{code_for_error(object, attribute, message)}
        """
      end

      script
    end

    def ajax_test(object, attribute)
      script = """
        var object_data = {};
        _.each(element.closest('form').find('input'), function(input) {
          if ( $(input).data('attribute') != undefined ) {
            object_data[$(input).data('attribute')] = $(input).val();
          }
        });
        $.ajax({
          url: '/validator/new',
          type: 'post',
          data: { 
            class: '#{object.class.name.underscore}',
            attribute: '#{attribute}',
            object: object_data//{'#{attribute}': element.val()}
          }
        }).done(function(data) {
          if (data.message != null) {
            error = true;
            message_for_#{object.class.name.underscore}_#{attribute}(element, data.message);
          } else {
            remove_message_for__#{object.class.name.underscore}_#{attribute}(element);
          }
        });
      """
      script
    end

    def code_for_error(object, attribute, message) 
      """
        error = true;
        message_for_#{object.class.name.underscore}_#{attribute}(element, \"#{message} \")
        }
      """
    end

    def json_regexp ( regexp )
      str = regexp.inspect
                  .sub('\\A' , '^')
                  .sub('\\Z' , '$')
                  .sub('\\z' , '$')
                  .sub(/^\// , '')
                  .sub(/\/[a-z]*$/ , '')
                  .gsub(/\(\?#.+\)/ , '')
                  .gsub(/\(\?-\w+:/ , '(')
                  .gsub(/\s/ , '')

      Regexp.new(str).source
    end
end
