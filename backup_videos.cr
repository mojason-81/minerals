# FIXME:
# Looks like when compiling this here on Ubuntu 18.04,
#   I'm introducing a dependency on a shared library, libevent-2.1-6
#   This causes the program to fail when running on Ubuntu 16.04 since
#   that package is neither installed nor available in the repos for 16.04
#
# More info: I'm thiking i saw this libevent-2.1-6 get installed
#   along with crystal.  So perhaps all I need to do is install Crystal on
#   my other machine, but that defeats some of the purpose of compiling
#   this script in the first place.

# TODOs:
# Maybe instead of taking in the directories and file extensions on the
#   command line, we read them in from a config file
# Maybe zip up the videos

require "file_utils"

def main
  if ARGV.size < 3
    puts "
      You're missing arguments.
      You need a source directory, target (backup) directory, and at least one file extension.
      i.e. /home/you/Videos /home/you/VideoBackup m4v\n\n"
    exit
  end

  # If current root doesn't exist, let the user know.
  if !Dir.exists?(ARGV[0])
    puts "Source directory \"#{ARGV[0]}\" doesn't seem to exist."
    return
  end
  # Create the backup directory if it doesn't exist
  if !Dir.exists?(ARGV[1])
    # 0o0775 is octal and it's rwxrwxr-x
    # For a reminder of how to add up the mode:
    #   https://www.lifewire.com/uses-of-command-chmod-2201064
    #   http://www.filepermissions.com/file-permission/0644
    puts "Creating directory #{ARGV[1]}"
    Dir.mkdir_p(ARGV[1], 0o0775)
  end
  current_root    = Dir.new(ARGV[0])
  backup_root     = Dir.new(ARGV[1])
  extensions      = ARGV[2..-1]
  source_patterns = extensions.map { |extension| "#{current_root.path}/**/*.#{extension}" }
  backup_patterns = extensions.map { |extension| "#{backup_root.path}/**/*.#{extension}" }
  source_files    = Dir.glob(source_patterns)
  backup_files    = Dir.glob(backup_patterns)

  reducer = Proc(Hash(String, String), String, Hash(String, String)).new { |acc, path|
    acc[File.basename(path)] = path
    return acc
  }

  backup_basenames = backup_files.reduce(
    {} of String => String
    # Same as
    # Hash(String, String).new
  ) { |acc, path| reducer.call(acc, path) }

  source_files.each do |file_path|
    # Check to see if the file is already in the backup directory.
    next if backup_basenames.fetch(File.basename(file_path), nil)

    puts "Found new file: #{file_path}"
    destination_directory = file_path.gsub(File.basename(file_path), "").gsub(current_root.path, backup_root.path)

    begin
      # Get the directory and create it if it doesn't exist
      if !Dir.exists?(destination_directory)
        # 0o0775 is octal and it's rwxrwxr-x
        puts "Creating new directory #{destination_directory}"
        Dir.mkdir_p(destination_directory, 0o0775)
      end

      destination_path = file_path.gsub(current_root.path, backup_root.path)
      FileUtils.cp(file_path, destination_path)
      puts "Copied new file to: #{destination_path}"
    rescue e
      puts "Something went wrong copying the file.\n#{e}"
    end
  end
end

main()
