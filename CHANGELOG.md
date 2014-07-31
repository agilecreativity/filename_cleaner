### 0.4.1

- Only support ruby 2.1.0+ as we use refinement

### 0.4.0

* Update to latest gems that do not use monkeypatch
* Use refinement instead of monkeypatch (using AgileUtils::HashExt)
* Be more precise about the gem version in the gemspec file
* Fix the rubocop style

### 0.3.11

* Remove the `core_ext`, and use method from `agile_utils`
* Update gemspec to latest gem versions

### 0.3.10

* Update travis-ci to remove the support for 1.9.3
* Update the Rakefile to use new API of `rubocop`
* Update `rubocop` to latest version

### 0.3.9

* Make `formatted_name` public so that it can be re-used in other projects
* Minor documentation cleanup

### 0.3.8

* Simplify the CLI usage

### 0.3.7

* Add the missing `code_lister` to gemspec file
* Add the `.ruby-version` from to `.gitignore`

### 0.3.6

* Fix the bugs that were introduced in 0.3.5 that caused the file to be renamed
  incorrectly.
* Add `--downcase` option to make lower case each word in the filename
* Add `--capitalize` option to capitalize each word in the filename
* Make `_` underscore the default value for `--sep-string`
* Remove less used optons
  - Remove `--inc-words` option!
  - Remove `--exc-words` option!
  - Remove `--ignore-case` option!
* Consistently use double quote for string
* Update Coverall configuration
  - add `.coveralls.yml`
  - adjust the settings in `test/test_helper.rb`

### 0.3.5

* Yank - due to one bug that cause the files to be renamed incorrectly!

### 0.3.4

* Code refactoring

### 0.3.3

* Update gemspec not to use git for include of files
* Rename 'CHANGELOGS.md' to 'CHANGELOG.md'

### 0.3.2

* Add coveralls badges

### 0.3.1

* Correct the sample usage in README.md

### 0.3.0

* Cleanup and simplify the apis
* Rename `--dry-run` to `--commit`
* Remove the `--non-exts` options to only support file with extension

### 0.2.0

* Cleanup the APIs
  * rename `sanitize_filename` to `sanitize_name_with_extension`
  * add `sanitize_name` for name that does not have any extension
* Make non-public apis private
* Add core_ext/object/blank.rb

### 0.1.1

* Remove the last char from the filename if it is not numbers or letters

### 0.1.0

* First [Semantic Versioning][] version.

### 0.0.3

* Remove the namespace and code refactoring

### 0.0.2

* Update gem dependencies to the latest version
* Update gemspec to reflect the actual feature of the gem
* Update and cleanup README.md

### 0.0.1

* Initial release

[Semantic Versioning]: http://semver.org
