module ConfigHelper
  def current_version
    config[:current_version]
  end

  def versions
    config[:versions]
  end

  def versions_grouped_by_status
    versions.reverse.group_by { status(_1) }
  end

  private

  def status(version)
    if version == "v2.5"
      "Current release"
    elsif %w[v2.4 v2.3 v2.2].include?(version)
      "Legacy release"
    else
      "Deprecated release"
    end
  end
end
