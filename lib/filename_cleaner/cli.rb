require 'thor'
require 'agile_utils'
require 'fileutils'
require_relative '../filename_cleaner'

module FilenameCleaner
  class CLI < Thor
    desc 'clean', 'Remove special characters in the list of files'
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::EXTS
    method_option *AgileUtils::Options::NON_EXTS
    method_option *AgileUtils::Options::INC_WORDS
    method_option *AgileUtils::Options::EXC_WORDS
    method_option *AgileUtils::Options::IGNORE_CASE
    method_option *AgileUtils::Options::RECURSIVE
    method_option *AgileUtils::Options::VERSION

    method_option :sep_char,
                  aliases: '-s',
                  desc: 'Separator char to use',
                  default: '.'

    method_option :dry_run,
                  type: :boolean,
                  aliases: '-d',
                  desc: 'Perform a dry run only',
                  default: true
    def clean
      opts = options.symbolize_keys
      if opts[:version]
        puts "You are using Filename Cleaner version #{FilenameCleaner::VERSION}"
        exit
      end
      run(opts)
    end

    desc 'usage', 'Display help screen'
    def usage
      puts <<-EOS
Usage:
  filename_cleaner clean [OPTIONS]

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory)
  -e, [--exts=one two three]               # List of extensions to search for
  -f, [--non-exts=one two three]           # List of files without extension to search for
  -n, [--inc-words=one two three]          # List of words to be included in the result if any
  -x, [--exc-words=one two three]          # List of words to be excluded from the result if any
  -i, [--ignore-case], [--no-ignore-case]  # Match case insensitively
                                           # Default: true
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -v, [--version], [--no-version]          # Display version information
  -s, [--sep-char=SEP_CHAR]                # Separator char to use
                                           # Default: .
  -d, [--dry-run], [--no-dry-run]          # Perform a dry run only
                                           # Default: true
      EOS
    end

    default_task :usage

    private

    def run(options = {})
      files = CodeLister.files(options || [])
      if files.empty?
        puts "No match found for your options :#{options}"
      else
        files.each do |file|
          dirname  = File.dirname(File.expand_path(file))
          filename = File.basename(file)
          sanitized_name = FilenameCleaner::sanitize_filename(filename, options[:sep_char])
          old_name = File.expand_path(file)
          new_name = File.expand_path([dirname, sanitized_name].join(File::SEPARATOR))

          if !options[:dry_run]
            if new_name != old_name
              puts "FYI: rename #{old_name} -> #{new_name}"
              FileUtils.mv old_name, new_name
            else
              puts "FYI: same file #{old_name}"
            end
          else
            puts 'No changes will be applied as this is a dry-run'
          end

        end
      end
    end
  end
end
