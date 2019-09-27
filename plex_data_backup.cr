require "zip"
require "file_utils"

# TODO: Maybe instead of hard-coding the directories here, read them in from a config file

def main
  root_plex_dir = "/var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server"
  backup_drive  = "/mnt/19792965-aed7-4700-b61c-187d669717a0"
  zip_file      = "#{backup_drive}/plex_data_backup.zip"
  zip_backup    = "#{backup_drive}/plex_data_backup.bak.zip"
  plex_data     = "#{root_plex_dir}/**/*.*"
  preferences   = "#{root_plex_dir}/Preferences.xml"
  source_files  = Dir.glob([plex_data, preferences]).reject { |path| File.directory?(path) }

  if File.exists?(zip_file)
    FileUtils.mv(zip_file, zip_backup)
  end

  begin
    File.open(zip_file, "w") do |file|
      Zip::Writer.open(file) do |zip|
        source_files.each do |sf|
          zip.add(sf, File.open(sf))
        end
      end
    end
    if File.exists?(zip_backup)
      FileUtils.rm(zip_backup)
    end
  rescue e
    puts "Something went wrong.\n#{e}"
    FileUtils.rm([zip_file]) if File.exists?(zip_file)
    if File.exists?(zip_backup)
      FileUtils.mv(zip_backup, zip_file)
    end
  end
end

main()