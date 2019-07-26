require "file_utils"
CURRENT_ROOT = "/home/jason/Project/minerals/current/"
BAKUP_ROOT   = "/home/jason/Project/minerals/bakup/"
CR_GLOB      = "**/*.cr"
TXT_GLOB     = "**/*.txt"

current = Dir.[CURRENT_ROOT + CR_GLOB, CURRENT_ROOT + TXT_GLOB]
bakup = Dir.[BAKUP_ROOT + CR_GLOB, BAKUP_ROOT + TXT_GLOB]

reducer = Proc(Hash(String, String), String, Hash(String, String)).new { |acc, path|
  acc[File.basename(path)] = path
  return acc
}

current_basenames = current.reduce(
  Hash(String, String).new
) { |acc, path| reducer.call(acc, path) }

bakup_basenames = bakup.reduce(
  Hash(String, String).new
) { |acc, path| reducer.call(acc, path) }

current.each do |file_path|
  if !bakup_basenames.fetch(File.basename(file_path), nil)
    puts "Found new file: #{file_path}"
    begin
      FileUtils.cp(file_path, file_path.gsub(CURRENT_ROOT, BAKUP_ROOT))
      puts "Copied new file to: #{file_path.gsub(CURRENT_ROOT, BAKUP_ROOT)}"
    rescue e
      puts "Something went wrong copying the file.\n#{e}"
    end
  end
end
