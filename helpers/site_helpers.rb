module SiteHelpers
  def page_title
    title = "Bundler: "
    if current_page.data.title
      title << current_page.data.title
    else
      title << "The best way to manage your Ruby applications dependencies"
    end
    title
  end

end
