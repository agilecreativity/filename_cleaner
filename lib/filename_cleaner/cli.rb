require "thor"
require "agile_utils"
require "fileutils"
require_relative "../filename_cleaner"
module FilenameCleaner
  class CLI < Thor
    # rubocop:disable AmbiguousOperator, LineLength
    desc "rename", "Sanitize and rename file with special characters"
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::EXTS
    method_option *AgileUtils::Options::RECURSIVE
    method_option *AgileUtils::Options::VERSION
    method_option :sep_char,
                  aliases: "-s",
                  desc: "Separator char to use",
                  default: "_"
    method_option :downcase,
                  type: :boolean,
                  aliases: "-d",
                  desc: "Convert each word int the filename to lowercase",
                  default: false
    method_option :capitalize,
                  type: :boolean,
                  aliases: "-t",
                  desc: "Capitalize each word in the filename",
                  default: false
    method_option :commit,
                  type: :boolean,
                  aliases: "-c",
                  desc: "Commit your changes",
                  default: false
    def rename
      opts = options.symbolize_keys
      if opts[:version]
        puts "You are using Filename Cleaner version #{FilenameCleaner::VERSION}"
        exit
      end
      sanitize_and_rename(opts)
    end

    desc "usage", "Display help screen"
    def usage
      puts <<-EOS
Usage:
  filename_cleaner rename

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory)
  -e, [--exts=one two three]               # List of extensions to search for
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -s, [--sep-char=SEP_CHAR]                # Separator char to use
                                           # Default: _
  -d, [--downcase], [--no-downcase]        # Convert each word int the filename to lowercase
                                           # Default: --no-downcase
  -t, [--capitalize], [--no-capitalize]    # Capitalize each word in the filename
                                           # Default: --no-capitalize
  -c, [--commit], [--no-commit]            # Commit your changes
                                           # Default: --no-commit
  -v, [--version], [--no-version]          # Display version information
                                           # Default: --no-version

Sanitize and rename file with special characters
      EOS
    end
    # rubocop:enable AmbiguousOperator, LineLength
    default_task :usage

  private

    # rubocop:disable LineLength
    def sanitize_and_rename(options = {})
      files = CodeLister.files(options)
      if files.empty?
        puts "No match found for your options :#{options}"
      else
        files.each_with_index do |file, index|
          puts "FYI: process : #{index + 1} of #{files.size}"
          dirname  = File.dirname(File.expand_path(file))
          filename = File.basename(file)
          new_name = formatted_name(filename, options)
          old_name = File.expand_path(file)
          new_name = File.expand_path([dirname, new_name].join(File::SEPARATOR))
          compare_and_rename(old_name, new_name, options[:commit])
        end
        unless options[:commit]
          puts "--------------------------------------------------------------"
          puts "This is a dry run, to commit your change, please use --commit option"
          puts "--------------------------------------------------------------"
        end
      end
    end
    # rubocop:enable LineLength

    def formatted_name(filename, options)
      sep_char = options[:sep_char]
      sanitized_name = FilenameCleaner.sanitize(filename, sep_char, true)

      # First split the two part so that only name is used!
      basename = File.basename(sanitized_name, ".*")
      extname  = File.extname(sanitized_name)
      if options[:downcase]
        basename = basename.split(sep_char).map(&:downcase).join(sep_char)
      end
      if options[:capitalize]
        basename= basename.split(sep_char).map(&:capitalize).join(sep_char)
      end
      "#{basename}#{extname}"
    end

    def compare_and_rename(old_name, new_name, commit)
      if new_name != old_name
        puts "FYI: old name: #{old_name}"
        puts "FYI: new name: #{new_name}"
        # Don't override the file if it is already exist!
        unless File.exist?(new_name) || !commit
          FileUtils.mv old_name, new_name
        end
      else
        puts "FYI: same file #{old_name}"
      end
    end
  end
end
