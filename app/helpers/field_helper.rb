module FieldHelper

  def create_search_field(item_field, options = {})
    if item_field.field_type.field_type == 'value'
      return search_text_field(item_field, options)
    end
    if item_field.field_type.field_type == 'memo'
      return search_text_area_field(item_field, options)
    end
    if item_field.field_type.field_type == 'list'
      return search_list_field(item_field, options)
    end
    if item_field.field_type.field_type == 'boolean'
      return search_boolean_field(item_field, options)
    end
  end
  
  def search_text_field(item_field, options = {})
    result = content_tag :label, item_field.label, for: item_field.name
    result += text_field_tag item_field.name, options[:value], 
      class: "form-control", placeholder: item_field.name
  end
  
  def search_text_area_field(item_field, options = {})
    result = content_tag :label, item_field.label, for: item_field.name
    result += text_area_tag item_field.name, options[:value], 
      class: "form-control", placeholder: item_field.name
  end
  
  def search_list_field(item_field, options = {})
    result = content_tag :label, item_field.label, for: item_field.name
    result += select_tag item_field.name, options_for_select(item_field.field_type.field_posibilities.map {|p| p.text }, options[:value]), include_blank: true, class: "form-control"
  end
  
  def search_boolean_field(item_field, options = {})
    content_tag :div, class: 'checkbox' do
      concat content_tag :label, item_field.label, for: item_field.name
      concat check_box_tag item_field.name, 'on', options[:value] == 'on'
    end
  end
  
  def create_table_header(fields)
    counter = 0
    result = "<th>Acciones</th>"
    fields.each do |field|
      if counter < 4
        counter += 1
        if field.act_as == 'principal'
          result += content_tag :th do
            concat field.name
          end
        end
        if field.act_as == 'secondary'
          result += content_tag :th do
            concat field.name
          end
        end
        if field.act_as == 'small_description'
          result += content_tag :th do
            concat field.name
          end
        end
        if field.act_as == 'category'
          result += content_tag :th do
            concat field.name
          end
        end
        if field.act_as == 'subcategory'
          result += content_tag :th do
            concat field.name
          end
        end
        if field.act_as.nil?
          result += content_tag :th do
            concat field.name
          end
        end
      end
    end
    result
  end
  
  def create_table_body(fields, lines)
    result = ""
    lines.each do |line|
      current_version = line.current_version
      counter = 0
      if counter == 0
        result += "<tr>"
        result += """
          <td>
             <a href='#{show_product_path(line.item_version.item.name, line.current_version.id)}' class='btn btn-default btn-default'><span class='glyphicon glyphicon-search'></span></a>
        """
        
        if line.active
          result += "<a href='#{edit_product_path(line.item_version.item.name, line.current_version.id)}' class='btn btn-default btn-default'><span class='glyphicon glyphicon-pencil'></span></a>"
            
          
          result += "<a data-confirm='Esta a punto de eliminar un registro, esta seguro?' class='btn btn-default btn-default' data-method='delete' href='#{destroy_product_path(line.item_version.item.name, line.current_version.id)}' rel='nofollow'><span class='glyphicon glyphicon-trash'></span></a>"
        else
          result += "<a data-confirm='Esta a punto de activar un registro, esta seguro?' class='btn btn-default btn-default' data-method='patch' href='#{activate_product_path(line.item_version.item.name, line.current_version.id)}' rel='nofollow'><span class='glyphicon glyphicon-flash'></span></a>"
        end
        result += "</td>"
      end
      fields.each do |field|
        if counter < 4
          counter += 1
          if field.act_as == 'principal'
            result += content_tag :td do
              concat current_version.value(act_as: field.act_as).try(:value)
            end
          end
          if field.act_as == 'secondary'
            result += content_tag :td do
              concat current_version.value(act_as: field.act_as).try(:value)
            end
          end
          if field.act_as == 'small_description'
            result += content_tag :td do
              concat current_version.value(act_as: field.act_as).try(:value)
            end
          end
          if field.act_as == 'category'
            result += content_tag :td do
              concat current_version.value(act_as: field.act_as).try(:value)
            end
          end
          if field.act_as == 'subcategory'
            result += content_tag :td do
              concat current_version.value(act_as: field.act_as).try(:value)
            end
          end
          if field.act_as.nil?
            result += content_tag :td do
              concat current_version.value(name: field.name).try(:value)
            end
          end
        end
      end
      result += "</tr>"
    end
    result
  end
  
  def create_form_field(item_field, options = {})
    if item_field.field_type.field_type == 'value'
      return form_text_field(item_field, options)
    end
    if item_field.field_type.field_type == 'memo'
      return form_text_area_field(item_field, options)
    end
    if item_field.field_type.field_type == 'list'
      return form_list_field(item_field, options)
    end
    if item_field.field_type.field_type == 'boolean'
      return form_boolean_field(item_field, options)
    end
    if item_field.field_type.field_type == 'image'
      return form_image_field(item_field, options)
    end
  end
  
  def form_text_field(item_field, options = {})
    result = content_tag :label, item_field.label, for: item_field.name
    result += options[:form].text_field :value, class: "form-control", placeholder: item_field.name
    result += options[:form].hidden_field :item_field_id
      
  end
  
  def form_text_area_field(item_field, options = {})
    result = content_tag :label, item_field.label, for: item_field.name
    result += options[:form].text_area :value,
      class: "form-control", placeholder: item_field.name
    result += options[:form].hidden_field :item_field_id
  end
  
  def form_list_field(item_field, options = {})
    result = content_tag :label, item_field.label, for: item_field.name
    result += options[:form].select :value, options_for_select(item_field.field_type.field_posibilities.map {|p| p.text }, options[:value].value),  { include_blank: true }, {class: "form-control"}
    result += options[:form].hidden_field :item_field_id
  end
  
  def form_boolean_field(item_field, options = {})
    result = content_tag :div, class: 'checkbox' do
      concat content_tag :label, item_field.label, for: item_field.name
      concat options[:form].check_box item_field.name, 'on', options[:value].value == 'on'
    end
    result += options[:form].hidden_field :item_field_id
  end
  
  def form_image_field(item_field, options = {})
    result = content_tag :label, item_field.label, for: item_field.name
    result += content_tag :p do
      concat image_tag options[:value].image_url(:small).to_s if options[:value].image?
    end
    result += options[:form].file_field :image
    result += options[:form].hidden_field :image_cache
    result += options[:form].hidden_field :item_field_id
  end
end
