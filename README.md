## filename_cleaner

[![Gem Version](https://badge.fury.io/rb/filename_cleaner.svg)][gem]
[![Dependency Status](https://gemnasium.com/agilecreativity/filename_cleaner.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/agilecreativity/filename_cleaner.png)][codeclimate]
[![Build Status](https://secure.travis-ci.org/agilecreativity/filename_cleaner.png)][travis-ci]
[![Coverage Status](https://coveralls.io/repos/agilecreativity/filename_cleaner/badge.png?branch=master)][coveralls]

[gem]: http://badge.fury.io/rb/filename_cleaner
[gemnasium]: https://gemnasium.com/agilecreativity/filename_cleaner
[codeclimate]: https://codeclimate.com/github/agilecreativity/filename_cleaner
[travis-ci]: http://travis-ci.org/agilecreativity/filename_cleaner
[coveralls]: https://coveralls.io/r/agilecreativity/filename_cleaner?branch=master

Quickly rename list of files with extension and replace any special characters with
with any given string.

Currently any string that are not one of letters (a..z, A..Z),
numbers (0..9), _ (underscore), - (dash), and ' ' spaces string
are first squeezed into one string and then replaced by any given string/char [default to . (a single dot)].

Optionally, you could also

- capitalized each words in the output
- make all words in output lower case
- use more than one character as the separator string if you prefer

### Installation

```sh
gem install filename_cleaner
```

#### Use as command line interface (CLI)

Just type `filename_cleaner` without any options to see the list of help

```
Usage:
  filename_cleaner

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
```

To perform the dry-run without make any changes to the file system:

```
cd ~/projects/files
filename_cleaner --base-dir . --exts java rb --recursive --sep-char _
```

To make your change permanent:

```
cd ~/projects/files
filename_cleaner --base-dir . --exts java rb --recursive --sep-char _ --commit
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
# Treat the input as having extension (e.g. at least one dot within the input)
new_name = FilenameCleaner.sanitize('some b@d fil$name.txt', '_', true)
puts new_name # => 'some_b_d_fil_name.txt'

# Treat the input as having no extension (ignore the meaning of within the input)
new_name = FilenameCleaner.sanitize('some b@d fil$name.txt', '_', false)
puts new_name # => 'some_b_d_fil_name_txt'
```

### Contributing

Bug reports and suggestions for improvements are always welcome,
GitHub pull requests are even better!.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[rubocop]: https://github.com/bbatsov/rubocop
