# FIXME:
# Looks like when compiling this here on Ubuntu 18.04,
# I'm introducing a dependency on a shared library, libevent-2.1-6
# This causes the program to fail when running on Ubuntu 16.04 since
# that package is neither installed nor available in the repos for 16.04

# TODOs:
# let's create the directories if they don't exist
# let's backup plex data also
#  plex data is found in /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/
#  just zip the whole darn thing and copy it over to the other drive
#  need admin (or need to chmod) the Preferences.xml file
require "file_utils"

if ARGV.size < 3
  puts "
    You're missing arguments.
    You need a source directory, target (backup) directory, and at least one file extension.
    i.e. /home/you/Videos /home/you/VideoBackup m4v\n\n"
  exit
end

# TODOs:
# If current root doesn't exist
#   Tell the user or print a log and exit.
# It the backup root doesn't exist
#   Create it.
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
  {} of String => String
  # Same as
  # Hash(String, String).new
) { |acc, path| reducer.call(acc, path) }

bakup_basenames = bakup_files.reduce(
  {} of String => String
  # Same as
  # Hash(String, String).new
) { |acc, path| reducer.call(acc, path) }

source_files.each do |file_path|
  # Check to see if the file is already in the backup directory.
  if !bakup_basenames.fetch(File.basename(file_path), nil)
    puts "Found new file: #{file_path}"
    begin
      # TODO:
      # Strip base name from file_path
      # Use that to check if Dir exists
      # Create directory if it doesn't exist
      FileUtils.cp(file_path, file_path.gsub(current_root.path, bakup_root.path))
      puts "Copied new file to: #{file_path.gsub(current_root.path, bakup_root.path)}"
    rescue e
      puts "Something went wrong copying the file.\n#{e}"
    end
  end
end
