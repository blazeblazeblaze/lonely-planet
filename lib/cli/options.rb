class MissingFileError < StandardError; end
class FilePermissionError < StandardError; end

module Cli
  class Options
    attr_accessor :taxonomy_path, :destinations_path

    def valid?
      raise(
        MissingFileError.new, "Files provided do not exist") unless exist?

      raise(
        FilePermissionError.new, "No permissions to read files") unless readable?

      true
    end

    def exist?
      File.exist?(taxonomy_path.to_s) && File.exist?(destinations_path.to_s)
    end

    def readable?
      File.readable?(taxonomy_path.to_s) && File.readable?(destinations_path.to_s)
    end
  end
end
