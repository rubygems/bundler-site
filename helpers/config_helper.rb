module ConfigHelper
  def current_version
    config[:current_version]
  end

  def versions
    config[:versions]
  end
end