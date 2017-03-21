require 'zip'

module OO
  class Zip

    attr_accessor :inputDir, :outputFile

    def exist?(input_folder)
      File.exist? (input_folder)
    end

    def write()
      entries = Dir.entries(@inputDir); entries.delete("."); entries.delete("..")
      io = ::Zip::File.open(@outputFile, ::Zip::File::CREATE);
      writeEntries(entries, "", io)
      io.close();
    end

    private
    def writeEntries(entries, path, io)
      entries.each do |e|
        zipFilePath = path == "" ? e : File.join(path, e)
        diskFilePath = File.join(@inputDir, zipFilePath)
        if  File.directory?(diskFilePath)
          io.mkdir(zipFilePath)
          subdir =Dir.entries(diskFilePath); subdir.delete("."); subdir.delete("..")
          writeEntries(subdir, zipFilePath, io)
        else
          io.get_output_stream(zipFilePath) { |f| f.puts(File.open(diskFilePath, "rb").read())}
        end
      end
    end
  end
end
