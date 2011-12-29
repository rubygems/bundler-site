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
      'v1.1/shared/command',
      :locals => {
        :name => command.name,
        :desc => command.desc,
        :opts => command.opts
      }
    )
  end
end
