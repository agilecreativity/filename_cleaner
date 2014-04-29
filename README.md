## FilenameClenaer

[![Gem Version](https://badge.fury.io/rb/filename_cleaner.svg)](http://badge.fury.io/rb/filename_cleaner)

Remove special characters from a filename using the simple rule. Currently any string that are not one of
letters (a..z, A..Z), numbers (0..9), _ (underscore), - (dash), and ' ' spaces string
are replaced by the prefered separator char [default to . (dot)].

### Installation

Add this line to your application's Gemfile:

    gem 'filename_cleaner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filename_cleaner

### Usage

```sh
gem install filename_cleaner
filename_cleaner clean
```

#### As command line interface (CLI)

Just type `filename_cleaner` without any options to see the list of help

```
Usage:
  filename_cleaner clean

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

Sanitize filename
```

To perform the dry-run without make any changes to the file system:

```
cd ~/projects/files
filename_cleaner clean --base-dir . --extes java rb --recursive --sep-char '_'
```

To make your change permanent:

```
cd ~/projects/files
filename_cleaner clean --base-dir . --extes java rb --recursive --sep-char '_' --no-dry-run
```

#### As library in your project

Add this line to your application's Gemfile:

    gem 'filename_cleaner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filename_cleaner

```

- Use the default separator string '.'

```ruby
require 'filename_cleaner'
clean_name = FilenameCleaner::Utils.sanitize_filename('some b@d fil$name.txt')
puts clean_name # => 'some.b.d.fil.name.txt'

```

- Specify the separator string

```ruby
require 'filename_cleaner'
clean_name = FilenameCleaner::Utils.sanitize_filename('some b@d fil$name.txt', '_')
puts clean_name # => 'some_b_d_fil_name.txt'

```

### Changelogs

#### 0.0.1

- Initial release

### Contributing

Bug reports and suggestions for improvements are always welcome,
GitHub pull requests are even better!.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[agile_utils]: https://rubygems.org/gems/agile_utils
[rubocop]: https://github.com/bbatsov/rubocop
