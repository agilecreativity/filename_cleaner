require_relative '../../test_helper'
describe FilenameCleaner do
  # context '#sanitize_with_dot' do
  #   it 'works with simple input' do
  #     FilenameCleaner.sanitize_with_dot('any txt').must_equal 'any.txt'
  #     FilenameCleaner.sanitize_with_dot('this is a long filename.txt').must_equal 'this.is.a.long.filename.txt'
  #   end
  #   it 'works with text with extension' do
  #     FilenameCleaner.sanitize_with_dot('filename.txt').must_equal 'filename.txt'
  #   end
  #   it 'strips the end of string if not letters or numbers' do
  #     FilenameCleaner.sanitize_with_dot('filename .txt').must_equal 'filename.txt'
  #     FilenameCleaner.sanitize_with_dot('filename  .txt').must_equal 'filename.txt'
  #     FilenameCleaner.sanitize_with_dot('filename   !.txt').must_equal 'filename.txt'
  #   end
  # end
  context '#sanitize_name_with_extension' do
    describe 'file with extension' do
      it 'replaces mutilple consecutive chars with one' do
        FilenameCleaner.sanitize_name_with_extension('some!!!$file$:%.txt').must_equal 'some.file.txt'
      end
      it 'works with default separator' do
        FilenameCleaner.sanitize_name_with_extension('some file.txt').must_equal 'some.file.txt'
      end
      it 'works with non-default separator' do
        FilenameCleaner.sanitize_name_with_extension('some file.txt', '_').must_equal 'some_file.txt'
      end
    end
    describe 'file without extension' do
      it 'replaces mutilple consecutive chars with one' do
        FilenameCleaner.sanitize_name_with_extension('some!!!$file$:%.').must_equal 'some.file'
      end
      context 'using default separator' do
        it 'works with simple input' do
          FilenameCleaner.sanitize_name_with_extension('Gemfile').must_equal 'Gemfile'
        end
        it 'works with complex input' do
          FilenameCleaner.sanitize_name_with_extension('File$without!extension').must_equal 'File.without.extension'
        end
      end
      context 'with non-default separator char' do
        it 'works with simple input' do
          FilenameCleaner.sanitize_name_with_extension('Gemfile', '_').must_equal 'Gemfile'
        end
        it 'works with complex input' do
          FilenameCleaner.sanitize_name_with_extension('File$without!extension', '-').must_equal 'File-without-extension'
        end
      end
      context 'end of the filename' do
        it 'strips the end of string if not letters or numbers' do
          FilenameCleaner.sanitize_name_with_extension('filename .txt').must_equal 'filename.txt'
          FilenameCleaner.sanitize_name_with_extension('filename  .txt').must_equal 'filename.txt'
          FilenameCleaner.sanitize_name_with_extension('filename   !.txt').must_equal 'filename.txt'
        end
      end
   end
  end
end
