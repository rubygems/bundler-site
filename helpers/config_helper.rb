module ConfigHelper
  def latest_version
    config[:latest_version]
  end

  def versions
    config[:versions]
  end

  def versions_with_documentation_page
    versions.select {|version| documentation_path(current_page_without_version, version) }
  end

  private

  def status(version)
    if version == "v2.6"
      "Current release"
    elsif %w[v2.5 v2.4 v2.3].include?(version)
      "Legacy release"
    else
      "Deprecated release"
    end
  end
end
