require_relative 'cli/parser'
require_relative 'app_data'
require_relative 'file_writer'
require_relative 'destination_list'

require_relative 'renderer/page'
require_relative 'renderer/destination'

class Program
  attr_reader :cli_options, :f_writer, :data

  def initialize
    @cli_options = Cli::Parser.new
    @f_writer    = FileWriter.new

    prepare_app_data
  end

  def process
    destination_list.each do |id, destination|
      f_writer.new_file(id)

      f_writer << Renderer::Page.render do
        Renderer::Destination.render(destination)
      end

      f_writer.close
    end
  end

  private

  def prepare_app_data
    @data = AppData.new(cli_options.parse)
    data.load
  end

  def destination_list
    @_destination_list ||= DestinationList.new(
      data.destinations, data.taxonomies
    )
  end
end
