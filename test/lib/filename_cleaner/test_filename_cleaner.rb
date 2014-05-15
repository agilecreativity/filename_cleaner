require_relative "../../test_helper"
describe FilenameCleaner do
  context "#sanitize" do
    describe "without extension" do
      it "works with simple input" do
        FilenameCleaner.sanitize("any txt").must_equal "any.txt"
        FilenameCleaner.sanitize("any txt", "-").must_equal "any-txt"
      end

      it "works with text containing the dot" do
        FilenameCleaner.sanitize("text with a dot.txt").must_equal "text.with.a.dot.txt"
        FilenameCleaner.sanitize("text with a dot.txt", "_").must_equal "text_with_a_dot_txt"
      end
      it "replaces many consecutive special characters with one" do
        FilenameCleaner.sanitize("text with!@**! multiple chars").must_equal "text.with.multiple.chars"
        FilenameCleaner.sanitize("text with!@**! multiple chars", "_").must_equal "text_with_multiple_chars"
      end
      it "strips all special characters at the end" do
        FilenameCleaner.sanitize("filename .txt_").must_equal "filename.txt"
        FilenameCleaner.sanitize("filename .txt_!$#$#", "_").must_equal "filename_txt"
      end
    end
    describe "with extension" do
      context "file with extension" do
        it "replaces mutilple consecutive chars with one" do
          FilenameCleaner.sanitize("some!!!$file$:%.txt", ".", true).must_equal "some.file.txt"
        end
        it "works with default separator" do
          FilenameCleaner.sanitize("some file.txt", ".", true).must_equal "some.file.txt"
        end
        it "works with non-default separator" do
          FilenameCleaner.sanitize("some file.txt", "_", true).must_equal "some_file.txt"
        end
      end
      context"file without extension" do
        it "replaces mutilple consecutive chars with one" do
          FilenameCleaner.sanitize("some!!!$file$:%", ".", true).must_equal "some.file"
        end
        context "using default separator" do
          it "works with simple input" do
            FilenameCleaner.sanitize("Gemfile", ".", true).must_equal "Gemfile"
          end
          it "works with complex input" do
            FilenameCleaner.sanitize("File$without!extension", ".", true).must_equal "File.without.extension"
          end
        end
        context "with non-default separator char" do
          it "works with simple input" do
            FilenameCleaner.sanitize("Gemfile", "_", true).must_equal "Gemfile"
          end
          it "works with complex input" do
            FilenameCleaner.sanitize("File$without!extension", "-", true).must_equal "File-without-extension"
          end
        end
        context "special characters at boundary" do
          it "does not strip special characters that from extension" do
            FilenameCleaner.sanitize("filename!!#@.txt!!", ".", true).must_equal "filename.txt!!"
          end
          it "strips the special characters that come before the extension" do
            FilenameCleaner.sanitize("filename  !#@!.txt", "_", true).must_equal "filename.txt"
          end
        end
      end
    end
  end
end
