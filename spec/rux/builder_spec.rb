require "spec_helper"

module Rux
  RSpec.describe Builder do
    describe "#word_start" do
      it "adds a word boundary" do
        builder = Builder.new do
          word_start
        end

        expect(builder).to build_regex "\\b"
      end
    end

    describe "#one_or_more" do
      context "given a parameter" do
        it "adds a plus" do
          builder = Builder.new do
            one_or_more "a"
          end

          expect(builder).to build_regex "a+"
        end
      end

      context "given a block" do
        it "adds a plus" do
          builder = Builder.new do
            one_or_more do
              group(capture: false) do
                literal "abc"
              end
            end
          end

          expect(builder).to build_regex "(?:abc)+"
        end
      end
    end

    describe "#zero_or_more" do
      context "given a string" do
        it "adds a star" do
          builder = Builder.new do
            zero_or_more "a"
          end

          expect(builder).to build_regex "a*"
        end
      end
    end

    describe "#zero_or_one" do
      context "given a string" do
        it "adds a ?" do
          builder = Builder.new do
            zero_or_one "a"
          end

          expect(builder).to build_regex "a?"
        end
      end
    end

    describe "#literal" do
      it "adds a literal string" do
        builder = Builder.new do
          literal "a"
        end

        expect(builder).to build_regex "a"
      end

      it "escapes special values" do
        builder = Builder.new do
          literal "\*?{}."
        end

        expect(builder).to build_regex "\\*\\?\\{\\}\\."
      end
    end

    describe "#whitespace" do
      it "adds a whitespace \s" do
        builder = Builder.new do
          whitespace
        end

        expect(builder).to build_regex "\s"
      end
    end

    describe "convenience groups" do
      specify "#letters to match a-zA-Z" do
        expect(Builder.new.letters).to eq "[a-zA-Z]"
      end

      specify "#numbers to match 0-9" do
        expect(Builder.new.numbers).to eq "[0-9]"
      end
    end

    describe "#group" do
      it "captures groups" do
        builder = Builder.new do
          group do
            one_or_more "a"
            literal "bc"
          end
        end

        expect(builder).to build_regex "(a+bc)"
      end

      it "captures nested regexps" do
        builder = Builder.new do
          group do
            literal "n"
            group do
              literal "an"
            end
            literal "a"
          end
        end

        expect(builder).to build_regex "(n(an)a)"
      end

      it "captures named groups" do
        builder = Builder.new do
          literal "health:"
          space
          group "health" do
            one_or_more numbers
          end
        end

        expect(builder).to build_regex "health:\s(?<health>[0-9]+)"
      end

      context "with the capture option as false" do
        it "produces a non-capture group" do
          builder = Builder.new do
            group(capture: false) do
              literal "abc"
            end
          end

          expect(builder).to build_regex "(?:abc)"
        end
      end
    end
  end
end
