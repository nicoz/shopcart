module ItemsHelper

  def item_image(value, size)
    if value.try(:image)
      image_tag value.image_url(size), class: 'featurette-image img-responsive'
    end
  end

end
