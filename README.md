## Filename Cleaner

[![Gem Version](https://badge.fury.io/rb/filename_cleaner.svg)](http://badge.fury.io/rb/filename_cleaner)
[![Dependency Status](https://gemnasium.com/agilecreativity/filename_cleaner.png)](https://gemnasium.com/agilecreativity/filename_cleaner)
[![Code Climate](https://codeclimate.com/github/agilecreativity/filename_cleaner.png)](https://codeclimate.com/github/agilecreativity/filename_cleaner)

Quickly rename list of files (with or without extensions) and replace any special characters with
a specific valid string (or separator char).

Currently any string that are not one of letters (a..z, A..Z),
numbers (0..9), _ (underscore), - (dash), and ' ' spaces string
are first squeezed into one string and then replaced by any given string/char [default to . (a single dot)].

### Installation

```sh
gem install filename_cleaner
```

#### Use as command line interface (CLI)

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

#### Us as library in your project

Add this line to your application's Gemfile:

```
gem 'filename_cleaner'
```

And then execute:

```
$bundle
```

Example Usage:

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

#### 0.0.3

- Remove the namespace and code refactoring

#### 0.0.2

- Update gem dependencies to the latest version
- Update gemspec to reflect the actual feature of the gem
- Update and cleanup README.md

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
