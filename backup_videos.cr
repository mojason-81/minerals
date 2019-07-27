# TODOs:
# let's create the directories if they don't exist
require "file_utils"

if ARGV.size < 3
  puts "\nYou're missing arguments.\nYou need a source directory, target (backup) directory, and at least one file extension.\ni.e. /home/you/Videos /home/you/VideoBackup m4v\n\n"
  exit
end

current_root    = Dir.new(ARGV[0])
bakup_root      = Dir.new(ARGV[1])
extensions      = ARGV[2..-1]
source_patterns = extensions.map { |extension| "#{current_root.path}/**/*.#{extension}" }
backup_patterns = extensions.map { |extension| "#{bakup_root.path}/**/*.#{extension}" }
source_files    = Dir.glob(source_patterns)
bakup_files     = Dir.glob(backup_patterns)

reducer = Proc(Hash(String, String), String, Hash(String, String)).new { |acc, path|
  acc[File.basename(path)] = path
  return acc
}

current_basenames = source_files.reduce(
  Hash(String, String).new
) { |acc, path| reducer.call(acc, path) }

bakup_basenames = bakup_files.reduce(
  Hash(String, String).new
) { |acc, path| reducer.call(acc, path) }

source_files.each do |file_path|
  if !bakup_basenames.fetch(File.basename(file_path), nil)
    puts "Found new file: #{file_path}"
    begin
      FileUtils.cp(file_path, file_path.gsub(current_root.path, bakup_root.path))
      puts "Copied new file to: #{file_path.gsub(current_root.path, bakup_root.path)}"
    rescue e
      puts "Something went wrong copying the file.\n#{e}"
    end
  end
end
