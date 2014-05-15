module FilenameCleaner
  DOT = '.'
  class << self
    # Sanitize the any name with or without any extension
    #
    # @param [String] name the input string
    # @param [String] sep_char the separator char to be used
    # @return [String] output string with special chars replaced withe specified string
    def sanitize(name, sep_char = '.', have_extension = false)
      if have_extension
        sanitize_name_with_extension(name, sep_char)
      else
        sanitize_name_without_extension(name, sep_char)
      end
    end

    private

    # Sanitize the any name with or without any extension
    #
    # @param [String] name the input string
    # @param [String] sep_char the separator char to be used
    # @return [String] output string with special chars replaced withe specified string
    def sanitize_name_without_extension(name, sep_char = '.')
      replace_dot(sanitize_with_dot(name), sep_char)
    end

    # Sanitize filename that works with file with extension
    #
    # @param [String] name the input filename with extension
    # @return [String] the output file with special characters replaced
    def sanitize_name_with_extension(name, sep_char = '.')
      extension = File.extname(name)
      name_only = File.basename(name, ".*")
      name_only = replace_dot(sanitize_with_dot(name_only), sep_char)
      "#{name_only}#{extension}"
    end

    # Replace the multiple special characters with a dot string
    #
    # @param [String] name input file
    # @return [String] the new name with special characters replaced or removed.
    def sanitize_with_dot(name)
      # Replace any special characters with a dot
      name.gsub!(/[^0-9A-Za-z\-_ ]/, DOT)

      # Replace multiple occurrences of a given character with a dot
      ['-', '_', ' '].each do |c|
        name.gsub!(/#{Regexp.quote(c)}+/, DOT)
      end

      # Replace multiple occurrence of dot with one dot
      name.gsub!(/#{Regexp.quote(DOT)}+/, DOT)

      # Remove the last char if it is a dot
      name.gsub!(/\.$/, '') if name[-1] == DOT

      # return the result
      name
    end

    # Replace 'dot' string with a given string if specified
    def replace_dot(string, replace = nil)
      string.gsub!(/#{Regexp.quote(DOT)}+/, replace) if replace
      string
    end
  end
end
