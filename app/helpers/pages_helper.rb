module PagesHelper
  def installation_navigation_bar(start, step_one, step_two)
    result = content_tag :li, :class => start do
              link_to "Start", "#"
            end
    result += content_tag :li, :class => step_one do
                link_to "Create User", "#"
              end
    result += content_tag :li, :class => step_two do
                link_to "Configure", "#"
              end
  end
end
