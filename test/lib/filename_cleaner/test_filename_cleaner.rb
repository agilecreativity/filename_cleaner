require_relative '../../test_helper'
describe FilenameCleaner do
  context '#sanitize' do
    it 'works with simple input' do
      FilenameCleaner.sanitize('any txt').must_equal 'any.txt'
      FilenameCleaner.sanitize('this is a long filename.txt').must_equal 'this.is.a.long.filename.txt'
    end
    it 'works with text with extension' do
      FilenameCleaner.sanitize('filename.txt').must_equal 'filename.txt'
    end
    it 'strips the end of string if not letters or numbers' do
      FilenameCleaner.sanitize('filename .txt').must_equal 'filename.txt'
      FilenameCleaner.sanitize('filename  .txt').must_equal 'filename.txt'
      FilenameCleaner.sanitize('filename   !.txt').must_equal 'filename.txt'
    end
  end
  context '#sanitize_filename' do
    describe 'file with extension' do
      it 'replaces mutilple consecutive chars with one' do
        FilenameCleaner.sanitize_filename('some!!!$file$:%.txt').must_equal 'some.file.txt'
      end
      it 'works with default separator' do
        FilenameCleaner.sanitize_filename('some file.txt').must_equal 'some.file.txt'
      end
      it 'works with non-default separator' do
        FilenameCleaner.sanitize_filename('some file.txt', '_').must_equal 'some_file.txt'
      end
    end
    describe 'file without extension' do
      it 'replaces mutilple consecutive chars with one' do
        FilenameCleaner.sanitize_filename('some!!!$file$:%.').must_equal 'some.file'
      end
      context 'using default separator' do
        it 'works with simple input' do
          FilenameCleaner.sanitize_filename('Gemfile').must_equal 'Gemfile'
        end
        it 'works with complex input' do
          FilenameCleaner.sanitize_filename('File$without!extension').must_equal 'File.without.extension'
        end
      end
      context 'with non-default separator char' do
        it 'works with simple input' do
          FilenameCleaner.sanitize_filename('Gemfile', '_').must_equal 'Gemfile'
        end
        it 'works with complex input' do
          FilenameCleaner.sanitize_filename('File$without!extension', '-').must_equal 'File-without-extension'
        end
      end
      context 'end of the filename' do
        it 'strips the end of string if not letters or numbers' do
          FilenameCleaner.sanitize_filename('filename .txt').must_equal 'filename.txt'
          FilenameCleaner.sanitize_filename('filename  .txt').must_equal 'filename.txt'
          FilenameCleaner.sanitize_filename('filename   !.txt').must_equal 'filename.txt'
        end
      end
    end
  end
end
