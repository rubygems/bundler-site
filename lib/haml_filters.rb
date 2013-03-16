require 'uv'

module Haml::Filters
  module Highlight_Ruby
    include Haml::Filters::Base

    def render(text)
      text = text.strip
      result = Uv.parse( text, 'xhtml', 'ruby', false, 'sunburst')
      Haml::Helpers.preserve result
    end
  end

  module Highlight_Plain
    include Haml::Filters::Base

    def render(text)
      result = "<pre class='sunburst'>#{Haml::Helpers.preserve(text)}</pre>"
    end
  end
end
