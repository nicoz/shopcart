module ApplicationHelper
 def contact_form()
    capture do
      content_tag :div, :class => "contact" do
        form_tag() do
          concat label_tag("Your Email")
          concat text_field_tag(:mail)
          concat label_tag("Your Name")
          concat text_field_tag(:name)
          concat label_tag("Subject")
          concat text_field_tag(:subject)
          concat label_tag("Text")
          concat text_area_tag(:text, "", :size => "50x10")
        end
      end
    end
  end
end
