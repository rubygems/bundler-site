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
    if version == "v2.4"
      "Current release"
    elsif %w[v2.3 v2.2 v2.1].include?(version)
      "Legacy release"
    else
      "Deprecated release"
    end
  end
end
