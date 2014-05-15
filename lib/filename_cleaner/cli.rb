require 'thor'
require 'agile_utils'
require 'fileutils'
require_relative '../filename_cleaner'
module FilenameCleaner
  class CLI < Thor
    # rubocop:disable AmbiguousOperator, LineLength
    desc 'rename', 'Sanitize and rename file with special characters'
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::EXTS
    method_option *AgileUtils::Options::INC_WORDS
    method_option *AgileUtils::Options::EXC_WORDS
    method_option *AgileUtils::Options::IGNORE_CASE
    method_option *AgileUtils::Options::RECURSIVE
    method_option *AgileUtils::Options::VERSION
    method_option :sep_char,
                  aliases: '-s',
                  desc: 'Separator char to use',
                  default: '.'
    method_option :commit,
                  type: :boolean,
                  aliases: '-c',
                  desc: 'Commit your changes',
                  default: false
    def rename
      opts = options.symbolize_keys
      if opts[:version]
        puts "You are using Filename Cleaner version #{FilenameCleaner::VERSION}"
        exit
      end
      sanitize_and_rename(opts)
    end

    desc 'usage', 'Display help screen'
    def usage
      puts <<-EOS
Usage:
  filename_cleaner rename

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory name)
  -e, [--exts=one two three]               # List of extensions to search for
  -n, [--inc-words=one two three]          # List of words to be included in the result if any
  -x, [--exc-words=one two three]          # List of words to be excluded from the result if any
  -i, [--ignore-case], [--no-ignore-case]  # Match case insensitively
                                           # Default: true
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -v, [--version], [--no-version]          # Display version information
  -s, [--sep-char=SEP_CHAR]                # Separator char to use
                                           # Default: .
  -c, [--commit], [--no-commit]            # Commit your changes

Sanitize and rename file with special characters
      EOS
    end
    # rubocop:enable AmbiguousOperator, LineLength
    default_task :usage

    private

    def sanitize_and_rename(options = {})
      files = CodeLister.files(options)
      if files.empty?
        puts "No match found for your options :#{options}"
      else
        files.each_with_index do |file, index|
          puts "FYI: process : #{index + 1} of #{files.size}"
          dirname  = File.dirname(File.expand_path(file))
          filename = File.basename(file)
          sanitized_name = FilenameCleaner.sanitize(filename, options[:sep_char], true)
          old_name = File.expand_path(file)
          new_name = File.expand_path([dirname, sanitized_name].join(File::SEPARATOR))
          compare_and_rename(old_name, new_name, options[:commit])
        end
        unless options[:commit]
          puts '--------------------------------------------------------------'
          puts 'This is a dry run, to commit your change, please use --commit option'
          puts '--------------------------------------------------------------'
        end
      end
    end

    def compare_and_rename(old_name, new_name, commit = optons[:commit])
      if new_name != old_name
        puts "FYI: old name: #{old_name}"
        puts "FYI: new name: #{new_name}"
        FileUtils.mv old_name, new_name if commit
      else
        puts "FYI: same file #{old_name}"
      end
    end
  end
end
