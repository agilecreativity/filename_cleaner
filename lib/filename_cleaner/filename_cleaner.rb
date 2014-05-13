module FilenameCleaner
  DOT = '.'
  class << self
    # Sanitize filename that have the extension
    #
    # @param [String] filename the input filename with extension
    # @retyrn [String] the output file with special characters replaced.
    def sanitize_filename(filename, sep_char = '.')
      extension = File.extname(filename)
      if extension.empty?
        replace_dot!(sanitize(filename), sep_char)
      else
        name_only = File.basename(filename, ".*")
        name_only = replace_dot!(sanitize(name_only), sep_char)
        "#{name_only}#{extension}"
      end
    end

    # Clean the the input string to remove the special characters
    #
    # @param [String] filename input file
    # @return [String] the new file name with special characters replaced or removed.
    def sanitize(filename)
      # remove anything that is not letters, numbers, dash, underscore or space
      # Note: we intentionally ignore dot from the list
      filename.gsub!(/[^0-9A-Za-z\-_ ]/, DOT)

      # replace multiple occurrences of a given char with a dot
      ['-', '_', ' '].each do |c|
        filename.gsub!(/#{Regexp.quote(c)}+/, DOT)
      end

      # replace multiple occurrence of dot with one dot
      filename.gsub!(/#{Regexp.quote(DOT)}+/, DOT)

      # remove the last char if it is a dot
      filename.gsub!(/\.$/, '') if filename[-1] == DOT

      filename
    end

    private

    # replace 'dot' string with a agiven string if any
    def replace_dot!(string, replace = nil)
      string.gsub!(/#{Regexp.quote(DOT)}+/, replace) if replace
      string
    end
  end
end
