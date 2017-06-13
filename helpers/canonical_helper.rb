module CanonicalHelper
  def commands_toplevel_path(destination_path)
    destination_path.gsub(/^v(.*?)\//) { "/" }
  end
end
