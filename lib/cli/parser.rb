require 'optparse'
require_relative 'options'

module Cli
  class Parser
    def parse
      opt_parser.parse!
      args if args.valid?
    end

    private

    def args
      @_args ||= Options.new
    end

    def opt_parser
      OptionParser.new do |opts|
        opts.on("-tFILE_NAME", "--taxonomy=FILE_NAME", "taxonomy file") do |n|
          args.taxonomy_path = n
        end

        opts.on("-dFILE_NAME", "--destinations=FILE_NAME", "destinations file") do |n|
          args.destinations_path = n
        end
      end
    end
  end
end
