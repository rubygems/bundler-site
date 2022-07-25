class CommandInfo
  attr_accessor :name, :desc
  def option=(opt)
    opts << opt
  end
  def opts
    @opts ||= []
  end
end

module CommandReferenceHelper
  def command_table_row
    command = CommandInfo.new
    yield command
    partial(
      'shared/command',
      locals: {
        name: command.name,
        desc: command.desc,
        opts: command.opts
      }
    )
  end

  def slugize(str)
    str.sub(/^([^\s]*).*/, "\\1")
  end

  # Check if the argument path is a part of command references
  def command?(path)
    !!(%r{\A/v(.*)/bundle_(.*)\z} =~ path || # https://github.com/rubygems/bundler-site/issues/723 will remove this line
       %r{\A/(v(.*)/|)man\/(.*)\z} =~ path)
  end
end
