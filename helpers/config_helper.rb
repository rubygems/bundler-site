module ConfigHelper
  def current_version
    config[:current_version]
  end

  def versions
    config[:versions]
  end

  def versions_grouped_by_status
    versions.select {|version| documentation_path(current_page_without_version, version) }.reverse.group_by { status(_1) }
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
