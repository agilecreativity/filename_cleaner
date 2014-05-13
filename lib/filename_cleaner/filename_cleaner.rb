module FilenameCleaner
  DOT = '.'
  class << self
    # Sanitize the name without any extension
    def sanitize_name(name, sep_char = '.')
      replace_dot!(sanitize_with_dot(name), sep_char)
    end

    # Sanitize filename that have the extension
    #
    # @param [String] filename the input filename with extension
    # @return [String] the output file with special characters replaced.
    def sanitize_name_with_extension(filename, sep_char = '.')
      extension = File.extname(filename)
      name_only = File.basename(filename, ".*")
      name_only = replace_dot!(sanitize_with_dot(name_only), sep_char)
      "#{name_only}#{extension}"
    end

    private

    # Replace the multipe special characters with a dot
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

    # replace 'dot' string with a given string if specified
    def replace_dot!(string, replace = nil)
      string.gsub!(/#{Regexp.quote(DOT)}+/, replace) if replace
      string
    end
  end
end
