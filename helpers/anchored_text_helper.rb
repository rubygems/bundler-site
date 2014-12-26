require 'active_support/core_ext/string/inflections'

module AnchoredTextHelper
  def anchored_text(title)
    octicon_link = '<span class="octicon octicon-link"></span>'
    link_to(octicon_link, '', fragment: title.parameterize, id: title.parameterize, class: 'anchor') + title
  end
end
