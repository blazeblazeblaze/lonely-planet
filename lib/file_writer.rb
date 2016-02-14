require 'fileutils'

class NoFileToWrite < StandardError; end
class NoOpenFileError < StandardError; end

class FileWriter
  OUTPUT_DIR_NAME = "output"
  attr_reader :curr_file

  def initialize
    prepare_dir
    prepare_assets
    @curr_file = nil
  end

  def << content
    raise NoOpenFileError.new("Cannot write to this file.") unless executable?
    @curr_file << content
  end

  def close
    raise NoOpenFileError.new("Cannot close this file.") unless executable?
    @curr_file.close
  end

  def new_file(file_name)
    raise NoFileToWrite.new("No file to write to.") unless writable?
    @curr_file = File.open("#{OUTPUT_DIR_NAME}/#{file_name}.html", "w")
  end

  private

  def executable?
    @curr_file && !@curr_file.closed?
  end

  def writable?
    @curr_file.nil? || @curr_file.closed?
  end

  def prepare_dir
    FileUtils.mkdir_p OUTPUT_DIR_NAME
  end

  def prepare_assets
    FileUtils.cp_r "static", OUTPUT_DIR_NAME
  end
end
