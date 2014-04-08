module ServicesHelper

  def draw_value(service, key)
    raw ServiceInformation.where(service_id: service.id).where(key: key).first.value
  end
  
  def social_scripts()
    services = Service.where(active: true).where("service_type in ('Todo', 'Login')")
    result = ""
    services.each do |service|

      result += draw_value(service, 'SCRIPT')
    end
    raw result
  end
end
